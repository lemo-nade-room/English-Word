import Vapor
import Fluent

final class Ignore: Model {
    
    static let schema = "ignores"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "value")
    var value: Bool
    
    @Parent(key: "question_id")
    var question: Question
    
    @Parent(key: "user_id")
    var user: User
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, value: Bool, question: Question, user: User) throws {
        self.id = id
        self.value = value
        self.$question.id = try question.requireID()
        self.$user.id = try user.requireID()
    }
}
