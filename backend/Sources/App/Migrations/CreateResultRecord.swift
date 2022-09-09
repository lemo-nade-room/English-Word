import Vapor
import Fluent

extension ResultRecord {
    
    struct Migration: AsyncMigration {
        
        func prepare(on database: Database) async throws {
            try await database.schema(ResultRecord.schema)
                .id()
                .field(ResultRecord().$mode.key, .string, .required)
                .field(ResultRecord().$score.key, .string, .required)
                .field(ResultRecord().$date.key, .datetime, .required)
                .field(ResultRecord().$book.$id.key, .uuid, .required, .references(Book.schema, Book().$id.key))
                .field(ResultRecord().$user.$id.key, .uuid, .required, .references(User.schema, User().$id.key))
                .field("created_at", .datetime)
                .field("updated_at", .datetime)
                .field("deleted_at", .datetime)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(ResultRecord.schema)
                .delete()
        }
    }
}
