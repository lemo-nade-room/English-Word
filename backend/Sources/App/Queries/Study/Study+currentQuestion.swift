import Vapor
import Fluent
import SQLKit

extension Study {
    
    func currentQuestion(on db: Database) async throws -> StudyQuestion? {
        let study = try await Study.query(on: db)
            .filter(\.$id == (try requireID()))
            .with(\.$questions) {
                $0.with(\.$answer)
                $0.with(\.$question)
            }
            .first()
        guard let study = study else { fatalError("学習物がありません") }
        return study.questions
            .filter { $0.answer == nil }
            .min { $0.order < $1.order }
    }
    
    func beforeQuestion(on db: Database) async throws -> StudyQuestion? {
        let study = try await Study.query(on: db)
            .filter(\.$id == (try requireID()))
            .with(\.$questions) { $0.with(\.$answer) }
            .first()
        guard let study = study else { fatalError("学習物がありません") }
        return study.questions
            .filter { $0.answer != nil }
            .max { $0.order < $1.order }
    }
    
}
