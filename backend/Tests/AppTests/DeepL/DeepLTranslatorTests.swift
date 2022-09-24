@testable import App
import XCTVapor

final class DeepLTranslatorTests: XCTestCase {
    func testDeepL() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        
        guard let key = Environment.get("DeepL_API_KEY") else {
            XCTFail("Keyが設定されていない")
            return
        }
        
        let deepL = DeepLTranslator(client: app.client, key: key)
        
        let translateds = try await deepL.translate(source: ["language", "japanese"])
        XCTAssertEqual(["言語", "ジャパニーズ"], translateds)
    }
}
