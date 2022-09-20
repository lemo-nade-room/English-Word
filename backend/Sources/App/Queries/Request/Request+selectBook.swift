import Vapor
import Fluent


extension Request {
    
    func selectBook(_ book: Book) async throws {
        let user = try user()
        try await user.$books.attach(book, on: db)
    }
    
    func selectedBook() async throws -> Book? {
        let user = try user()
        try await user.$bookStates.load(on: db)
        guard let currentState = user.bookStates.max(by: { $0.createdAt! < $1.createdAt! }) else {
            return nil
        }
        try await currentState.$book.load(on: db)
        return currentState.book
    }
    
    func requireBook() async throws -> Book {
        guard let book = try await selectedBook() else {
            throw Abort(.badRequest)
        }
        return book
    }
}
