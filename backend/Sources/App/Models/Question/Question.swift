import Fluent
import Vapor

final class Question: Model {
    
    static let schema = "questions"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "jp")
    var jp: String
    
    @Field(key: "en")
    var en: String
    
    @Parent(key: "book_id")
    var book: Book
    
    @Field(key: "order")
    var order: Int
    
    @Children(for: \.$question)
    var ignores: [Ignore]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, jp: String, en: String, order: Int, book: Book) throws {
        self.id = id
        self.jp = jp
        self.en = en
        self.order = order
        self.$book.id = try book.requireID()
        deletedAt = nil
    }
}
