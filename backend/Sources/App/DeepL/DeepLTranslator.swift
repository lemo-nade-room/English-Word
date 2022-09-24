import Foundation
import Vapor

struct DeepLTranslator: Translatable {
    
    let client: Client
    
    let key: String
    
    static let API_URI = URI("https://api-free.deepl.com/v2/translate")
    
    func translate(source: [String]) async throws -> [String] {
        var translations = DeepLTranslations(translations: [])
        for texts in source.texts {
            let query = DeepLParameter(target: .Japanese, source: .English, texts: texts).query
            let response = try await client.post(Self.API_URI) { req in
                req.headers = headers
                req.body = ByteBuffer(bytes: [UInt8](query.utf8))
            }
            translations.append(try response.content.decode(DeepLTranslations.self))
        }
        return translations.translations.map { $0.text }
    }
    
    private var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(name: "Authorization", value: "DeepL-Auth-Key \(key)")
        headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")
        return headers
    }
}

fileprivate extension Array where Element == String {
    var texts: [[Element]] {
        stride(from: 0, to: self.count, by: 50).map {
            Array(self[$0..<Swift.min($0 + 50, self.count)])
        }
    }
}
