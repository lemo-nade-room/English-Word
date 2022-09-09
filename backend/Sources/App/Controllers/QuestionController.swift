import Foundation
import Vapor
import Fluent

struct QuestionController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let question = routes.grouped("question")
        question.get(use: index)
    }
    
    func index(req: Request) async throws -> PersonalBook {
        let user = req.auth.get(User.self)!
        let id = req.sessionBookId!
        
        return try await .fetch(by: user, in: id, on: req.db)
    }
    
    func create(req: Request) async throws -> HTTPStatus {
        guard let book = try await Book.find(req.sessionBookId!, on: req.db) else {
            throw Abort(.badRequest)
        }
        let newQuestion = try req.content.decode(RequestQuestion.self)
        try await newQuestion.create(in: book, on: req.db)
        return .created
    }
    
    func update(req: Request) async throws -> HTTPStatus {
        let question = try req.content.decode(RequestQuestion.self)
        try await question.update(on: req.db)
        return .ok
    }
}
