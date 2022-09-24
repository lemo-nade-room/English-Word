import Vapor
import Fluent

struct NewBook: Content {
    
    let title: String
    let text: String
    
    func save(translator: Translatable, on db: Database) async throws -> Book {
        let book = Book(title: title, text: text)
        try await book.save(on: db)
        
        let assets = try await WordAssets(on: db)
        let questions = try await questions(by: assets, in: book, translator: translator, on: db)
        try await questions.create(on: db)
        return book
    }
    
    private func questions(by assets: WordAssets,in book: Book, translator: Translatable, on db: Database) async throws -> [Question] {
        let enWords = self.enWords
        let translateds = try await enWords.translateds(translator: translator)
        var questions = [Question]()
        for (index, en) in enWords.enumerated() {
            let jp = assets.get(en: en.word) ?? translateds[index]
            questions.append(try .init(jp: jp, en: en.word, order: index, book: book))
        }
        return questions
    }
    
    private var enWords: [BookWord] {
        BookText(text: text).extractedWords
    }
}

