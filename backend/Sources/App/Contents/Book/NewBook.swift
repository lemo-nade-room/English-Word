import Vapor
import Fluent
import SwiftDeepLTranslation

struct NewBook: Content {
    
    let title: String
    let text: String
    
    func save(on db: Database) async throws {
        let book = Book(title: title, text: text)
        try await book.save(on: db)
        
        let assets = try await WordAssets(on: db)
        let questions = try await questions(by: assets, in: book, on: db)
        try await questions.create(on: db)
    }
    
    private func questions(by assets: WordAssets,in book: Book, on db: Database) async throws -> [Question] {
        
        let deepL = SwiftDeepLTranslation(key: Environment.get("DeepL_API_KEY")!)
        let enWords = self.enWords
        let translateds = try await enWords.translateds(deepL: deepL)
        
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

