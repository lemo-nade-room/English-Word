import Vapor
import Fluent

struct PersonalBook: Content {
    
    let id: UUID
    
    let title: String
    
    let questions: [PersonalQuestion]
    
    static func fetch(by user: User, in book: Book, on db: Database) async throws -> Self {
        
        guard
            let bookId = book.id,
            let book = try await Book.query(on: db)
            .filter(\.$id == bookId)
            .with(\.$questions, { question in
                question.with(\.$ignores) { ignore in
                    ignore.with(\.$user)
                }
            }).first()
        else {
            throw Abort(.badRequest)
        }
        
        let questions = try book.questions.map { question -> PersonalQuestion in
            let ignore = try question.isIgnore(for: user)
            return PersonalQuestion(id: question.id!, en: question.en, jp: question.jp, ignore: ignore )
        }
        
        return PersonalBook(id: bookId, title: book.title, questions: questions)
    }
}
