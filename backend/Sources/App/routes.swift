import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        ResultRecord().$book.$id.key.description
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: BookController())
}
