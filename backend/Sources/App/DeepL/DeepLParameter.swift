import Foundation
import Vapor

struct DeepLParameter: Content {
    
    var target_lang: String
    
    var source_lang: String?
    
    var text: [String]
    
    init(target: Language, source: Language? = nil, texts: [String]) {
        self.target_lang = target.rawValue
        self.source_lang = source?.rawValue
        self.text = texts
    }
    
    var query: String {
        var items = [URLQueryItem]()
        items.append(URLQueryItem(name: "target_lang", value: target_lang))
        if let source_lang = source_lang {
            items.append(URLQueryItem(name: "source_lang", value: source_lang))
        }
        for item in text {
            items.append(URLQueryItem(name: "text", value: item))
        }
        var components = URLComponents()
        components.queryItems = items
        
        let queryString = components.string!
        return String(queryString.suffix(queryString.count - 1))
    }
}
