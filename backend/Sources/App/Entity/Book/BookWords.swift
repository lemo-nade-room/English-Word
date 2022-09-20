import Foundation
import SwiftDeepLTranslation

extension Array where Element == BookWord {
    func translateds(deepL: SwiftDeepLTranslation) async throws -> [String] {
        try await deepL.translate(texts: map { $0.word }, from: .English, to: .Japanese)
    }
}
