import Vapor
import Fluent

extension StudyQuestion {
    func addLastAgain(on db: Database) async throws {
        try await self.$study.load(on: db)
        try await study.$questions.load(on: db)
        let maxOrder = study.questions.max { $0.order < $1.order }?.order ?? 0
        let newQuestion = try Self.init(order: maxOrder + 1, question: question, study: study)
        try await newQuestion.save(on: db)
    }
}
