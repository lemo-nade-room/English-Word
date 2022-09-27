import Vapor
import Fluent

struct BookTitleRepository {
    let db: Database
}

extension Request {
    var bookTitleReader: BookTitleReadable {
        BookTitleRepository(db: db)
    }
    var bookTitleUpdater: BookTitleUpdatable {
        BookTitleRepository(db: db)
    }
}

extension BookTitleRepository: BookTitleReadable {
    func read() async throws -> [BookTitle] {
        try await Book.query(on: db)
            .sort(\.$updatedAt, .descending)
            .all()
            .map { .init(id: (try $0.requireID()), title: $0.title) }
    }
}

extension BookTitleRepository: BookTitleUpdatable {
    func update(bookTitle: BookTitle) async throws {
        guard let book = try await (Book.find(bookTitle.id, on: db)) else {
            throw Abort(.badRequest, reason: "book ID: \(bookTitle.id) was not Found")
        }
        book.title = bookTitle.title
        try await book.update(on: db)
    }
}

