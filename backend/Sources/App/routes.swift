import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get { req async throws in
        return Study().$mode.field.key.description
    }
    
    try app.register(collection: LoginController())
    
    let api = app
        .grouped("api")
        .grouped(M())
        .grouped(User.Authenticator())
        .grouped(User.guardMiddleware())
    
    try api.register(collection: BookController())
    try api.register(collection: QuestionController())
    try api.register(collection: ResultController())
    try api.register(collection: StudyController())
}

struct M: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        print(request.headers)
        return try await next.respond(to: request)
    }
}
