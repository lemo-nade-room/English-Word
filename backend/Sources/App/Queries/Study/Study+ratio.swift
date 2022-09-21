import Vapor
import Fluent

extension Study {
    
    /** questions, questions.answer, book.questionsをloadしている場合のみ使用可能 */
    var score: String {
        mode == .lap ? ratio : lap
    }
    
    /** questionsとanswerをloadしている場合のみ使用可能 */
    var ratio: String {
        let correctCount = self.questions
            .filter { $0.answer?.isCorrect ?? false }
            .count
        let allCount = self.questions
            .filter { $0.answer != nil }
            .count
        return String(Int(Double(correctCount) / Double(allCount == 0 ? 1 : allCount) * 100.0)) + "%"
    }
    
    /** questionsとそのbook.questionsをloadしている場合のみ使用可能 */
    var lap: String {
        let questionCount = self.questions.count
        let originCount = self.book.questions.count
        return String(round(Double(questionCount) / Double(originCount) * 10) / 10) + "周"
    }
}
