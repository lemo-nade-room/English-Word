import Vapor
import Fluent

struct BookController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let book = routes.grouped("book")
        book.get(use: index)
        book.post(use: create)
        book.patch(use: update)
        book.delete(":id", use: remove)
    }
    
    func index(req: Request) async throws -> [BookTitle] {
        try await Book.query(on: req.db)
            .sort(\.$updatedAt, .descending)
            .all()
            .map { .init(book: $0) }
    }
    
    func create(req: Request) async throws -> HTTPStatus {
        let newBook = try req.content.decode(NewBook.self)
        try await newBook.save(on: req.db)
        return .created
    }
        
    func update(req: Request) async throws -> HTTPStatus {
        let title = try req.content.decode(BookTitle.self)
        guard let id = title.id, let book = try await Book.find(id, on: req.db) else {
            throw Abort(.badRequest)
        }
        book.title = title.title
        try await book.update(on: req.db)
        return .ok
    }
    
    func remove(req: Request) async throws -> HTTPStatus {
        guard let id = UUID(uuidString: req.parameters.get("id")!) else {
            throw Abort(.badRequest)
        }
        guard let book = try await Book.find(id, on: req.db) else {
            throw Abort(.badRequest)
        }
        try await Question.query(on: req.db)
            .filter(\.$book.$id == book.id!)
            .delete()
        try await book.delete(on: req.db)
        return .ok
    }
}
