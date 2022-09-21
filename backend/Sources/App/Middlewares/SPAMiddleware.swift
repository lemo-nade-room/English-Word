import Vapor

struct SPAMiddleware: AsyncMiddleware {

    let publicDirectory: String

    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        let response = try await next.respond(to: request)
        if response.status == .notFound {
            return request.fileio.streamFile(at: publicDirectory + "/index.html")
        }
        return response
    }
}
