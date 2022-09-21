import Vapor
import Fluent

extension StudyAnswer {
    struct Migration: AsyncMigration {

        func prepare(on database: Database) async throws {
            try await database.schema(StudyAnswer.schema)
                .id()
                .field(StudyAnswer().$isCorrect.key, .bool, .required)
                .field(StudyAnswer().$question.$id.key, .uuid, .required)
                .field(StudyAnswer().$study.$id.key, .uuid, .required)
                .field("created_at", .datetime)
                .field("deleted_at", .datetime)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(StudyAnswer.schema)
                .delete()
        }
    }
}
