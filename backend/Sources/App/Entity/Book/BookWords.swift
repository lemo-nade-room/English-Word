import Foundation
import Vapor

extension Array where Element == BookWord {
    func translateds(translator: Translatable) async throws -> [String] {
        try await translator.translate(source: map { $0.word })
    }
}
