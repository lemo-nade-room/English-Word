import Vapor
import Fluent

final class User: Model {
    
    static let schema = "users"
    
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "password")
    var passwordHash: String
    
    @Children(for: \.$user)
    var ignores: [Ignore]
    
    @Children(for: \.$user)
    var bookStates: [BookState]
    
    @Siblings(through: BookState.self, from: \.$user, to: \.$book)
    var books: [Book]
    
    @Children(for: \.$user)
    var studies: [Study]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, name: String, passwordHash: String) {
        self.id = id
        self.name = name
        self.passwordHash = passwordHash
    }
}
