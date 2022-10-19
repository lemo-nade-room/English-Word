import Vapor
import Fluent
import Foundation

extension User {
    struct Seeder: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await [
                User(name: "tanaka", passwordHash: try Bcrypt.hash(Environment.get("PASSWORD") ?? "password")),
                User(name: "Bob", passwordHash: try Bcrypt.hash("bob")),
                User(name: "Mike", passwordHash: try Bcrypt.hash("mike")),
            ].create(on: database)
        }

        func revert(on database: Database) async throws {
            try await User.query(on: database).delete()
        }
    }
}
