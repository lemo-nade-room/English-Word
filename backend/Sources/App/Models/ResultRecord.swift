import Vapor
import Fluent

final class ResultRecord: Model {
    
    static let schema = "result_records"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "mode")
    var mode: String
    
    @Field(key: "score")
    var score: String
    
    @Field(key: "date")
    var date: Date
    
    @Parent(key: "book_id")
    var book: Book
    
    @Parent(key: "user_id")
    var user: User
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, mode: String, score: String, date: Date = Date(), book: Book, user: User) throws {
        self.id = id
        self.mode = mode
        self.score = score
        self.date = date
        self.$book.id = try book.requireID()
        self.$user.id = try user.requireID()
    }
    
}
