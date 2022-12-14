import Vapor
import Fluent

struct BookController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let book = routes.grouped("book")
        book.get(use: index)
        book.post(use: create)
        book.put(":id", use: select)
        book.patch(use: update)
        book.delete(":id", use: remove)
    }
    
    func index(req: Request) async throws -> [BookTitle] {
        try await req.bookTitleReader.read()
    }
    
    func create(req: Request) async throws -> HTTPStatus {
        let newBook = try req.content.decode(NewBook.self)
        let book = try await newBook.save(translator: req.translator,on: req.db)
        try await req.selectBook(book: book)
        return .created
    }

    func select(req: Request) async throws -> HTTPStatus {
        guard let id = UUID(uuidString: req.parameters.get("id")!) else {
            throw Abort(.badRequest)
        }
        try await req.selectBook(id: id)
        return .ok
    }
        
    func update(req: Request) async throws -> HTTPStatus {
        let title = try req.content.decode(BookTitle.self)
        try await req.bookTitleUpdater.update(bookTitle: title)
        return .ok
    }
    
    func remove(req: Request) async throws -> HTTPStatus {
        guard let id = UUID(uuidString: req.parameters.get("id")!) else {
            throw Abort(.badRequest)
        }
        try await req.bookRemover.remove(id: id)
        return .ok
    }
}
