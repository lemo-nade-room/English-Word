import Vapor
import Fluent

struct UserAnswer: Content {
    
    let isCorrect: Bool
    
    func save(at study: Study, on db: Database) async throws {
        guard let currentQuestion = try await study.currentQuestion(on: db) else {
            throw Abort(.badRequest, reason: "現在解く為のクイズが存在しない")
        }
        try await db.transaction { transaction in
            if study.mode == .loop && !isCorrect {
                try await currentQuestion.addLastAgain(on: transaction)
            }
            let answer = try StudyAnswer(isCorrect: isCorrect, question: currentQuestion, study: study)
            try await study.$answers.create(answer, on: transaction)
        }
    }
}
