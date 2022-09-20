import Vapor

struct BookTitle: Content {
    let id: UUID?
    let title: String
    
    init(book: Book) {
        self.id = book.id
        self.title = book.title
    }
}
