import Foundation
import Vapor
import Fluent

struct QuestionController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let question = routes.grouped("question")
            .grouped(BookSelectedMiddleware())
        question.get(use: index)
        question.post(use: create)
        question.patch(use: update)
        question.delete(":id", use: remove)
    }
    
    func index(req: Request) async throws -> PersonalBook {
        let user = try req.user()
        let book = try await req.requireBook()
        return try await .fetch(by: user, in: book, on: req.db)
    }
    
    func create(req: Request) async throws -> HTTPStatus {
        let book = try await req.requireBook()
        let newQuestion = try req.content.decode(RequestQuestion.self)
        try await newQuestion.create(in: book, on: req.db)
        return .created
    }
    
    func update(req: Request) async throws -> HTTPStatus {
        let question = try req.content.decode(RequestQuestion.self)
        try await question.update(on: req.db)
        return .ok
    }
    
    func remove(req: Request) async throws -> HTTPStatus {
        guard let questionId = UUID(uuidString: req.parameters.get("id")!) else {
            throw Abort(.badRequest)
        }
        try await Question.query(on: req.db)
            .filter(\.$id == questionId)
            .delete()
        return .ok
    }
}
