import Vapor
import Fluent

final class BookState: Model {
    
    static let schema = "book_state"

    @ID(custom: "id")
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Parent(key: "book_id")
    var book: Book
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, user: User, book: Book) throws {
        self.id = id
        self.$user.id = try user.requireID()
        self.$book.id = try book.requireID()
        createdAt = nil
    }
    
}
