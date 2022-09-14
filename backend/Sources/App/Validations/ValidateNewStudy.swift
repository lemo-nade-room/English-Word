import Vapor
import Fluent

extension NewStudy: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("mode", as: String.self, is: .in("loop", "lap"))
    }
}
