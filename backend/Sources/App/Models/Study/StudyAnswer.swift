import Vapor
import Fluent

final class StudyAnswer: Model {
    
    static let schema = "study_answer"

    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "is_correct")
    var isCorrect: Bool
    
    @Parent(key: "study_question_id")
    var question: StudyQuestion
    
    @Parent(key: "study_id")
    var study: Study
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, isCorrect: Bool, question: StudyQuestion, study: Study) throws {
        self.id = id
        self.isCorrect = isCorrect
        self.$question.id = try question.requireID()
        self.$study.id = try study.requireID()
        self.createdAt = nil
    }
    
}
