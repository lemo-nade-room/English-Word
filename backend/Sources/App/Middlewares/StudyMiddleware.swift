import Vapor

struct StudyMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        let user = try request.user()
        guard try await user.currentStudy(on: request.db) != nil else {
            throw Abort(.badRequest, reason: "現在studyがありません")
        }
        return try await next.respond(to: request)
    }
}
