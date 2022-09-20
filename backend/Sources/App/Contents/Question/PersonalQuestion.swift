import Vapor

struct PersonalQuestion: Content {
    
    let id: UUID
    
    let en: String
    
    let jp: String
    
    let ignore: Bool
}
