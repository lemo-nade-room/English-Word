import Foundation
import SQLKit
import Vapor
import Fluent

struct WordAssets {
    
    private let en2jp: [String: String]
    
    init(on db: Database) async throws {
        guard let sql = db as? SQLDatabase else {
            fatalError("SQLデータベースじゃない")
        }
        let en = Question().$en.key.description
        let jp = Question().$jp.key.description
        let assets = try await sql.raw("""
             SELECT \(raw: en), (
                SELECT \(raw: jp)
                  FROM \(raw: Question.schema) AS JP
                 WHERE JP.\(raw: en) = EN.\(raw: en)
                 GROUP BY \(raw: jp)
                HAVING count(*) >= all(
                SELECT COUNT(*)
                  FROM \(raw: Question.schema) as MODE
                 WHERE MODE.\(raw: en) = EN.\(raw: en)
                 GROUP BY MODE.\(raw: jp)
                ))
              FROM \(raw: Question.schema) AS EN
             GROUP BY \(raw: en);
        """).all(decoding: WordAsset.self)
        
        var en2jp = [String: String]()
        for asset in assets {
            en2jp[asset.en] = asset.jp
        }
        self.en2jp = en2jp
    }
    
    func get(en: String) -> String? {
        return en2jp[en]
    }
}
