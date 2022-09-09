import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "english_word"
    ), as: .psql)
    
    app.passwords.use(.bcrypt)

    app.migrations.add(User.Migration())
    app.migrations.add(Book.Migration())
    app.migrations.add(ResultRecord.Migration())
    app.migrations.add(Question.Migration())
    app.migrations.add(Ignore.Migration())
    
    // register routes
    try routes(app)
}
