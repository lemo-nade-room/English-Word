import Vapor
import Fluent

extension User {
    
    func currentStudy(on db: Database) async throws -> Study? {
        try await self.$studies.load(on: db)
        return self.studies.max { $0.createdAt! < $1.createdAt! }
    }
}
