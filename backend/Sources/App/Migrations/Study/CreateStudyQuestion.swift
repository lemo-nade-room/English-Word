import Vapor
import Fluent

extension StudyQuestion {
    struct Migration: AsyncMigration {

        func prepare(on database: Database) async throws {
            try await database.schema(StudyQuestion.schema)
                .id()
                .field(StudyQuestion().$order.key, .int, .required)
                .field(StudyQuestion().$question.$id.key, .uuid, .required, .references(Question.schema, Question().$id.key, onDelete: .cascade))
                .field(StudyQuestion().$study.$id.key, .uuid, .required, .references(Study.schema, Study().$id.key, onDelete: .cascade))
                .field("created_at", .datetime)
                .field("deleted_at", .datetime)
                .unique(on: StudyQuestion().$order.key, StudyQuestion().$study.$id.key)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(StudyQuestion.schema)
                .delete()
        }
    }
}
