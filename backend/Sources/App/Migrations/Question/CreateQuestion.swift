import Vapor
import Fluent

extension Question {
    struct Migration: AsyncMigration {
        
        func prepare(on database: Database) async throws {
            try await database.schema(Question.schema)
                .id()
                .field(Question().$en.key, .string, .required)
                .field(Question().$jp.key, .string, .required)
                .field(Question().$order.key, .int, .required)
                .field(Question().$book.$id.key, .uuid, .required, .references(Book.schema, Book().$id.key))
                .field("created_at", .datetime)
                .field("updated_at", .datetime)
                .field("deleted_at", .datetime)
                .unique(on: Question().$order.key, Question().$book.$id.key)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(Question.schema)
                .delete()
        }
    }
}
