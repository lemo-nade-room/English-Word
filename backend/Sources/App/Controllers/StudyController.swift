import Vapor
import Fluent

struct StudyController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let study = routes.grouped("study")
            .grouped(StudyMiddleware())
        study.get(use: index)
        study.post(use: create)
        study.patch(use: answer)
        study.delete(use: rewind)
    }
    
    func index(req: Request) async throws -> CurrentQuestion {
        let user = try req.user()
        let study = try await user.currentStudy(on: req.db)!
        guard let question = try await CurrentQuestion(study: study, on: req.db) else {
            throw Abort(.badRequest, reason: "もう問題がありません")
        }
        return question
    }
    
    func create(req: Request) async throws -> HTTPStatus {
        let newStudy = try req.content.decode(NewStudy.self)
        let user = try req.user()
        let book = try await req.requireBook()
        try await newStudy.create(by: user, in: book, on: req.db)
        return .created
    }
    
    func answer(req: Request) async throws -> HTTPStatus {
        let answer = try req.content.decode(UserAnswer.self)
        let study = try await req.user().currentStudy(on: req.db)!
        try await answer.save(at: study, on: req.db)
        return .ok
    }
    
    func rewind(req: Request) async throws -> HTTPStatus {
        let user = try req.user()
        let study = try await user.currentStudy(on: req.db)!
        guard let beforeQuestion = try await study.beforeQuestion(on: req.db) else {
            throw Abort(.badRequest, reason: "戻る問題がない")
        }
        try await beforeQuestion.$answer.load(on: req.db)
        let answer = beforeQuestion.answer!
        try await answer.delete(on: req.db)
        if study.mode == .lap || answer.isCorrect {
            return .ok
        }
    
        let againQuestion = study.questions
            .filter { $0.$question.id == beforeQuestion.id! }
            .max { $0.order < $1.order }
        try await againQuestion?.delete(on: req.db)
    
        return .ok
    }
    
}
