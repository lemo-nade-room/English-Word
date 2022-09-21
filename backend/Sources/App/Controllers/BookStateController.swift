import Vapor
import Fluent

struct BookStateController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let book = routes.grouped("book", "state")
            .grouped(BookSelectedMiddleware())
        book.get(use: index)
    }
    
    func index(req: Request) async throws -> String {
        try await req.requireBook().title
    }
}
