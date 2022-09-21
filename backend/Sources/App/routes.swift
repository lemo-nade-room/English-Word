import Fluent
import Vapor

func routes(_ app: Application) throws {

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(SPAMiddleware(publicDirectory: app.directory.publicDirectory), at: .beginning)
    
    try app.register(collection: LoginController())
    
    let api = app
        .grouped("api")
        .grouped(User.Authenticator())
        .grouped(User.guardMiddleware())
    
    try api.register(collection: BookController())
    try api.register(collection: BookStateController())
    try api.register(collection: QuestionController())
    try api.register(collection: IgnoreController())
    try api.register(collection: ResultController())
    try api.register(collection: StudyController())
}
