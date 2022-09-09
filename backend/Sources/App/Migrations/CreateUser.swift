import Vapor
import Fluent

extension User {
    struct Migration: AsyncMigration {
        
        func prepare(on database: Database) async throws {
            try await database.schema(User.schema)
                .id()
                .field(User().$name.key, .string, .required)
                .field(User().$passwordHash.key, .string, .required)
                .field("created_at", .datetime)
                .field("updated_at", .datetime)
                .field("deleted_at", .datetime)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(User.schema)
                .delete()
        }
    }
}
