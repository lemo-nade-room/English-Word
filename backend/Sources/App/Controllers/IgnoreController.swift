import Foundation
import Vapor
import Fluent

struct IgnoreController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        let question = routes.grouped("ignore")
                .grouped(BookSelectedMiddleware())
        question.patch(use: update)
    }

    func update(req: Request) async throws -> HTTPStatus {
        let personalIgnore = try req.content.decode(PersonalIgnore.self)
        let user = try req.user()
        try await personalIgnore.save(by: user, on: req.db)
        return .ok
    }


}
