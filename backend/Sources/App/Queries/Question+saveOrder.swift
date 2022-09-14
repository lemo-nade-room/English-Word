import Vapor
import Fluent
import FluentSQL

extension Question {
    
    func saveOrder(on db: Database) async throws {
        if let exist = try await Self.find(id, on: db), exist.order == order {
            try await update(on: db)
            return
        }
        let askOrder = self.order
        order = try await maxOrder(on: db) + 1
        try await save(on: db)
        try await changeOrder(order: askOrder, on: db)
    }
    
    func changeOrder(order: Int, on db: Database) async throws {
        try await db.transaction { [self] transaction in
            guard let sql = transaction as? SQLDatabase else {
                fatalError("DBがSQLDatabaseではない")
            }
            
            try await self.shiftOrder(direction: .up, lower: order, on: sql)
            try await orderToPositiveNumber(on: sql)
            
            
            // 序列を変更する
            guard let beforeOrder = try await Self.find(self.id, on: transaction)?.order else {
                throw Abort(.custom(code: 500, reasonPhrase: "SQLが重複しました"))
            }
            self.order = order
            try await self.update(on: transaction)
            
            try await shiftOrder(direction: .down, lower: beforeOrder, on: sql)
            try await orderToPositiveNumber(on: sql)
        }
    }
    
    private func orderToPositiveNumber(on sql: SQLDatabase) async throws {
        let orderColumn = self.$order.key.description
        try await sql.raw("UPDATE \(raw: Question.schema) SET \(raw: orderColumn) = ABS(\(raw: orderColumn))").run()
    }
    
    private enum ShiftDirection: Int {
        case up = 1
        case down = -1
    }

    private func shiftOrder(direction: ShiftDirection, lower: Int, on sql: SQLDatabase) async throws {
        let orderColumn = self.$order.key.description
        let bookColumn = self.$book.$id.key.description
        try await sql.raw("""
            UPDATE \(raw: Question.schema)
               SET \(raw: orderColumn) = - (\(raw: orderColumn) + \(bind: direction.rawValue))
             WHERE \(raw: bookColumn) = '\(bind: self.$book.id)'
               AND \(raw: orderColumn) >= \(bind: lower)
        """).run()
    }
    
    private func maxOrder(on db: Database) async throws -> Int {
        guard let sql = db as? SQLDatabase else {
            fatalError("DBがSQLDatabaseではない")
        }
        return try await sql.raw("""
            SELECT MAX(order)
              FROM \(raw: Question.schema)
             WHERE book_id = '\(bind: self.$book.id)'
        """).first(decoding: Int.self) ?? 0
    }
}
