import Vapor
import Fluent
import Foundation

struct UserSeeder: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await User(name: "tanaka", passwordHash: try Bcrypt.hash("22")).create(on: database)
    }

    func revert(on database: Database) async throws {
        try await User.query(on: database).filter(\.$name == "tanaka").first()?.delete(on: database)
    }

}