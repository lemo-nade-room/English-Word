import Vapor
import Fluent

final class StudyQuestion: Model {
    
    static let schema = "study_question"

    @ID(custom: "id")
    var id: UUID?
    
    @Field(key: "order")
    var order: Int
    
    @Parent(key: "question_id")
    var question: Question
    
    @Parent(key: "study_id")
    var study: Study
    
    @OptionalChild(for: \.$question)
    var answer: StudyAnswer?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, order: Int, question: Question, study: Study) throws {
        self.id = id
        self.order = order
        self.$question.id = try question.requireID()
        self.$study.id = try study.requireID()
        self.createdAt = nil
    }
    
}
