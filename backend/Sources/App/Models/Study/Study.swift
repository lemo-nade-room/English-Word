import Vapor
import Fluent

enum StudyMode: String, Content {
    case loop, lap
}

enum StudyLanguageDirection: String, Content {
    case jp2en, en2jp
}

enum StudyOrderMode: String, Content {
    case random, order
}

final class Study: Model {
    
    static let schema = "study"

    @ID(custom: "id")
    var id: UUID?
    
    @Enum(key: "mode")
    var mode: StudyMode
    
    @Enum(key: "direction_mode")
    var direction: StudyLanguageDirection
    
    @Enum(key: "order_mode")
    var orderMode: StudyOrderMode
    
    @Parent(key: "user_id")
    var user: User
    
    @Parent(key: "book_id")
    var book: Book
    
    @Children(for: \.$study)
    var questions: [StudyQuestion]
    
    @Children(for: \.$study)
    var answers: [StudyAnswer]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, mode: StudyMode, direction: StudyLanguageDirection, orderMode: StudyOrderMode, user: User, book: Book) throws {
        self.id = id
        self.mode = mode
        self.direction = direction
        self.orderMode = orderMode
        self.$user.id = try user.requireID()
        self.$book.id = try book.requireID()
        createdAt = nil
    }
    
}

