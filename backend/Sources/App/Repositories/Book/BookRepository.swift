import Vapor
import Fluent

struct BookRepository {
    let db: Database
}

extension Request {
    var bookRemover: BookRemovable {
        BookRepository(db: db)
    }
}

extension BookRepository: BookRemovable {
    func remove(id: UUID) async throws {
        guard let book = try await Book.find(id, on: db) else {
            throw Abort(.notFound, reason: "book having id was \(id) was not found")
        }
        try await book.delete(on: db)
    }
}
