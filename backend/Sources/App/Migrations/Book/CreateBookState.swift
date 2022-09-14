import Vapor
import Fluent

extension BookState {
    struct Migration: AsyncMigration {

        func prepare(on database: Database) async throws {
            try await database.schema(BookState.schema)
                .id()
                .field(BookState().$user.$id.key, .uuid, .required)
                .field(BookState().$book.$id.key, .uuid, .required)
                .field("created_at", .datetime)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(BookState.schema)
                .delete()
        }
    }
}
