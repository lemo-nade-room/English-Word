import Foundation
import Vapor
import Fluent

struct RequestQuestion: Content {
    
    let id: UUID?
    
    let en: String
    
    let jp: String
    
    func create(in book: Book, on db: Database) async throws {
        try await Question(id: id, jp: jp, en: en, book: book).create(on: db)
    }
    
    func update(on db: Database) async throws {
        guard let question = try await Question.find(id, on: db) else {
            throw Abort(.badRequest)
        }
        question.en = en
        question.jp = jp
        try await question.update(on: db)
    }
}
