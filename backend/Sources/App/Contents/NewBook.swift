import Vapor
import Fluent

struct NewBook: Content {
    
    let title: String
    let text: String
    
    func save(on db: Database) async throws {
        let book = Book(title: title, text: text)
        try await book.save(on: db)
        
        let assets = try await Question.assets(on: db)
        let questions = try await questions(by: assets, in: book, on: db)
        try await questions.create(on: db)
    }
    
    private func questions(by assets: WordAssets,in book: Book, on db: Database) async throws -> [Question] {
        return try await withThrowingTaskGroup(of: Question.self) { group in
            for en in enWords {
                group.addTask {
                    let jp = try await searchJP(on: assets, en: en)
                    return try .init(jp: jp, en: en, book: book)
                }
            }
            
            return try await group.reduce(into: [Question]()) { results, question in
                results.append(question)
            }
        }
    }
    
    private func searchJP(on assets: WordAssets, en: String) async throws -> String {
        return assets.searchJP(by: en) ?? "とりあえず not Found"
    }
    
    private var enWords: [String] {
        let separated = text.components(separatedBy: CharacterSet(charactersIn: ",. '\""))
        let filtered = separated.filter { !["", " ", "\n"].contains($0) }
        return Array(Set(filtered))
    }
}

