import Vapor
import Fluent

final class Book: Model {
    
    static let schema = "books"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "original_text")
    var text: String
    
    @Children(for: \.$book)
    var questions: [Question]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, title: String, text: String) {
        self.id = id
        self.title = title
        self.text = text
        self.createdAt = nil
        self.deletedAt = nil
        self.updatedAt = nil
    }
}
