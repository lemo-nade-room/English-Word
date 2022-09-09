import Vapor
import Fluent
import Foundation

extension Question {
    
    static func assets(on db: Database) async throws -> WordAssets {
        let assets = try await Self.query(on: db).all()
            .map { WordAsset(en: $0.en, jp: $0.jp) }
        return .init(assets: assets)
    }
}
