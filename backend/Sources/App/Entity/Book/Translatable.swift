protocol Translatable {
    func translate(source: [String]) async throws -> [String]
}
