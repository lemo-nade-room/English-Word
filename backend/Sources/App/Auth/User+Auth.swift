import Vapor
import Fluent

extension User {
    struct Auth: Content {
        
        let name: String
        let password: String
        
        func user(on db: Database) async throws -> User? {
            try await User.query(on: db)
                .filter(\.$name == name)
                .first()
        }
        
        func create(req: Request) async throws {
            if try await user(on: req.db) != nil {
                throw Abort(.badRequest)
            }
            let passwordHash = try req.password.hash(password)
            let user = User(name: name, passwordHash: passwordHash)
            try await user.create(on: req.db)
        }
    }
}
