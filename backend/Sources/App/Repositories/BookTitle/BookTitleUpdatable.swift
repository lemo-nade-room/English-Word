import Vapor

protocol BookTitleUpdatable {
    func update(bookTitle: BookTitle) async throws
}
