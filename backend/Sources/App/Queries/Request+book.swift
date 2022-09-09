import Vapor
import Fluent

extension Request {
    
    var sessionBookId: UUID? {
        get {
            guard let id = session.data["book_id"] else { return nil }
            return UUID(uuidString: id)
        }
        set {
            session.data["book_id"] = newValue?.uuidString
        }
    }
    
    func book() async throws -> Book {
        guard
            let id = sessionBookId,
            let book = try await Book.find(id, on: db)
        else {
            throw Abort(.badRequest)
        }
        return book
    }
    
    func setBook(book: Book) {
        sessionBookId = book.id
    }
}
