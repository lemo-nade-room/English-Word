import Vapor
import Fluent

extension Study {
    struct Migration: AsyncMigration {

        func prepare(on database: Database) async throws {
            let modeType = try await database.enum("mode_type")
                .case(StudyMode.loop.rawValue)
                .case(StudyMode.lap.rawValue)
                .create()
            
            let languageDirection = try await database.enum("language_direction")
                .case(StudyLanguageDirection.jp2en.rawValue)
                .case(StudyLanguageDirection.en2jp.rawValue)
                .create()
            
            let orderMode = try await database.enum("order_mode")
                .case(StudyOrderMode.random.rawValue)
                .case(StudyOrderMode.order.rawValue)
                .create()
            
            
            try await database.schema(Study.schema)
                .id()
                .field(Study().$mode.field.key, modeType, .required)
                .field(Study().$direction.field.key, languageDirection, .required)
                .field(Study().$orderMode.field.key, orderMode, .required)
                .field(Study().$user.$id.key, .uuid, .required)
                .field(Study().$book.$id.key, .uuid, .required)
                .field("created_at", .datetime)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(Study.schema)
                .delete()
            
            try await database.enum("order_mode").delete()
            try await database.enum("language_direction").delete()
            try await database.enum("mode_type").delete()
        }
    }
}
