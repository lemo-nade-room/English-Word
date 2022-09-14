import Vapor

struct StudyResult: Content {
    
    let score: String
    let mode: String
    let when: String
    
    init(score: String, mode: String, when: String) {
        self.score = score
        self.mode = mode
        self.when = when
    }
}
