import Vapor
import Fluent

extension Book {
    struct Migration: AsyncMigration {

        func prepare(on database: Database) async throws {
            try await database.schema(Book.schema)
                .id()
                .field(Book().$title.key, .string, .required)
                .field(Book().$text.key, .string, .required)
                .field("created_at", .datetime)
                .field("updated_at", .datetime)
                .field("deleted_at", .datetime)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(Book.schema)
                .delete()
        }
    }
}
