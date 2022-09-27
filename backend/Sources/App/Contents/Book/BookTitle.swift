import Vapor

struct BookTitle: Content {
    let id: UUID
    let title: String
}
