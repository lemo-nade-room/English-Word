import Vapor

struct DeepLTranslation: Content {
    let detected_source_language: Language
    let text: String
}

struct DeepLTranslations: Content {
    
    let translations: [DeepLTranslation]
    
    mutating func append(_ added: Self) {
        self =  .init(translations: translations + added.translations)
    }
}
