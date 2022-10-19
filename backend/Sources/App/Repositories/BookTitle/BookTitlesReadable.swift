protocol BookTitleReadable {
    func read() async throws -> [BookTitle]
}
