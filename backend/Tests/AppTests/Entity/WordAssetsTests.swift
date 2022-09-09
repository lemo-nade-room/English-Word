@testable import App
import XCTVapor

class WordAssetsTests: XCTestCase {
    
    private let assets = WordAssets(assets: [
        WordAsset(en: "make", jp: "作る"),
        WordAsset(en: "merge", jp: "合成する"),
        WordAsset(en: "make", jp: "作る"),
        WordAsset(en: "have", jp: "所有する"),
        WordAsset(en: "make", jp: "を〜にする"),
        WordAsset(en: "have", jp: "をさせる"),
        WordAsset(en: "that", jp: "である"),
        WordAsset(en: "that", jp: "ところの"),
        WordAsset(en: "that", jp: "あの"),
        WordAsset(en: "that", jp: "ところの"),
        WordAsset(en: "that", jp: "あの"),
        WordAsset(en: "that", jp: "あの"),
        
    ])
    
    func test単一ヒットしたもの() throws {
        XCTAssertEqual("合成する", assets.searchJP(by: "merge"))
    }
    
    func test複数ヒットしたもので多い方() throws {
        XCTAssertEqual("作る", assets.searchJP(by: "make"))
        XCTAssertEqual("あの", assets.searchJP(by: "that"))
    }
    
    func test存在しないもの() throws {
        XCTAssertEqual(nil, assets.searchJP(by: "this"))
    }
    
}
