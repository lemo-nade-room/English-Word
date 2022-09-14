import Vapor

struct BookSelectedMiddleware: AsyncMiddleware {
    
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        guard try await request.selectedBook() != nil else {
            throw Abort(.badRequest)
        }
        return try await next.respond(to: request)
    }
}
