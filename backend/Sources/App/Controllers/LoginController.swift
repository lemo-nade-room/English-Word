import Foundation
import Vapor
import Fluent

struct LoginController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let auth = routes.grouped("auth")
        auth.post(use: create)
        auth.patch(use: login)
    }
    
    func create(req: Request) async throws -> HTTPStatus {
        let authUser = try req.content.decode(User.Auth.self)
        try await authUser.create(req: req)
        return .created
    }
    
    func login(req: Request) async throws -> String {
        let authUser = try req.content.decode(User.Auth.self)
        guard let user = try await authUser.user(on: req.db) else {
            throw Abort(.unauthorized)
        }
        guard try req.password.verify(authUser.password, created: user.passwordHash) else {
            throw Abort(.unauthorized)
        }
        return user.verifyUser()
    }
}
