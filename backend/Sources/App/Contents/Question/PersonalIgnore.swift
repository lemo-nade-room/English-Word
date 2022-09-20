import Vapor
import Fluent

struct PersonalIgnore: Content {

    let questionID: UUID

    let ignore: Bool

    func save(by user: User, on db: Database) async throws {
        guard let question = try await Question.find(questionID, on: db) else {
            throw Abort(.notFound)
        }
        let ignore = try Ignore(value: self.ignore, question: question, user: user)
        try await question.$ignores.create(ignore, on: db)
    }
}
