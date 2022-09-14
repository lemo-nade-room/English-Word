import Vapor
import Fluent

extension Ignore {
    struct Migration: AsyncMigration {
        
        func prepare(on database: Database) async throws {
            try await database.schema(Ignore.schema)
                .id()
                .field(Ignore().$value.key, .bool, .required)
                .field(Ignore().$question.$id.key, .uuid, .required, .references(Question.schema, Question().$id.key))
                .field(Ignore().$user.$id.key, .uuid, .required, .references(User.schema, User().$id.key))
                .field("created_at", .datetime)
                .field("updated_at", .datetime)
                .field("deleted_at", .datetime)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(Ignore.schema)
                .delete()
        }
    }
}
