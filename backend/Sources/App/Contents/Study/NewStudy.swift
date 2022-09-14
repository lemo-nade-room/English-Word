import Vapor
import Fluent

struct NewStudy: Content {
    
    let mode: StudyMode
    let direction: StudyLanguageDirection
    let orderMode: StudyOrderMode
    
    func create(by user: User, in book: Book, on db: Database) async throws {
        let study = try Study(mode: mode, direction: direction, orderMode: orderMode, user: user, book: book)
        try await study.create(on: db)
        let allQuestions = try await Question.query(on: db)
            .with(\.$ignores)  { $0.with(\.$user) }
            .all()
        
        let studyQuestions = try allQuestions
            .filter { $0.book.id == book.id }
            .filter { !(try $0.isIgnore(for: user)) }
            .enumerated()
            .map { index, question in
                try StudyQuestion(order: index, question: question, study: study)
            }
        try await studyQuestions.create(on: db)
    }
}
