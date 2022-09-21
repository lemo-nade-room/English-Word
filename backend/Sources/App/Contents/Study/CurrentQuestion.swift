import Vapor
import Fluent

struct CurrentQuestion: Content {
    
    let title: String
    
    let question: String
    
    let answer: String
    
    let count: String
    
    let ratio: String
    
    init?(study: Study, on db: Database) async throws {
        let study = try await Study.query(on: db)
            .filter(\.$id == (try study.requireID()))
            .with(\.$book)
            .with(\.$questions) { $0.with(\.$answer) }
            .first()
        guard let study = study else { fatalError("学習中のものが存在しない") }
        guard let studyQuestion = try await study.currentQuestion(on: db) else { return nil }
        
        title = study.book.title
        
        let en = studyQuestion.question.en
        let jp = studyQuestion.question.jp
        
        (question, answer) = study.direction == .jp2en ? (jp, en) : (en, jp)
        
        count = "\(studyQuestion.order + 1)/\(study.questions.count)"
        
        ratio = study.ratio
    }
    
}
