import Vapor
import Fluent

extension StudyAnswer {
    struct Migration: AsyncMigration {

        func prepare(on database: Database) async throws {
            try await database.schema(StudyAnswer.schema)
                .id()
                .field(StudyAnswer().$isCorrect.key, .bool, .required)
                .field(StudyAnswer().$question.$id.key, .uuid, .required, .references(StudyQuestion.schema, StudyQuestion().$id.key, onDelete: .cascade))
                .field(StudyAnswer().$study.$id.key, .uuid, .required, .references(Study.schema, Study().$id.key, onDelete: .cascade))
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
