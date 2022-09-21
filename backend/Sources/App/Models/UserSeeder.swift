import Vapor
import Fluent
import Foundation

struct UserSeeder: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await User(name: "tanaka", passwordHash: try Bcrypt.hash(Environment.get("PASSWORD") ?? "password")).create(on: database)
    }

    func revert(on database: Database) async throws {
        try await User.query(on: database).filter(\.$name == Environment.get("USERNAME") ?? "username").first()?.delete(on: database)
    }

}
