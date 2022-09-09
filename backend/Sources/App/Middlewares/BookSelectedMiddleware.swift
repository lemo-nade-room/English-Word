import Vapor

struct BookSelectedMiddleware: AsyncMiddleware {
    
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        if request.sessionBookId != nil {
            return try await next.respond(to: request)
        }
        throw Abort(.badRequest)
    }
}
