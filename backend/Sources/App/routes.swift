import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get { req async throws in
        return Study().$mode.field.key.description
    }
    
    try app.register(collection: LoginController())
    
    let api = app
        .grouped("api")
        .grouped(User.Authenticator())
        .grouped(User.guardMiddleware())
    
    try api.register(collection: BookController())
    try api.register(collection: QuestionController())
    try api.register(collection: ResultController())
    try api.register(collection: StudyController())
}
