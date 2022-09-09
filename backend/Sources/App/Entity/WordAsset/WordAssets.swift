import Foundation

struct WordAssets {
    
    let assets: [WordAsset]
    
    /** 同率の場合、ランダムとなる */
    func searchJP(by en: String) -> String? {
        return candidates(by: en)
            .mostJP()
    }
    
    private func mostJP() -> String? {
        return Dictionary(grouping: assets, by: { $0.jp })
            .max { $0.value.count < $1.value.count }?.key
    }
    
    
    private func candidates(by en: String) -> WordAssets {
        return WordAssets(assets: assets.filter { $0.en == en })
    }
}
