import Vapor
import Fluent

struct BookTitleReader: BookTitleReadable {
    
    let db: Database
    
    func read() async throws -> [BookTitle] {
        try await Book.query(on: db)
            .sort(\.$updatedAt, .descending)
            .all()
            .map { .init(id: (try $0.requireID()), title: $0.title) }
    }
}

extension Request {
    var bookTitleReader: BookTitleReadable {
        BookTitleReader(db: db)
    }
}
