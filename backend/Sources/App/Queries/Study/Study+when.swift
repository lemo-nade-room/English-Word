import Foundation

fileprivate let 一時間: TimeInterval = 60 * 59
fileprivate let 一日: TimeInterval = 一時間 * 24

extension Study {
    var when: String {
        let interval = Date().timeIntervalSince(createdAt!)
        
        if interval < 一時間 {
            return String(Int((interval / 60)) + 1) + "分前"
        }
        
        if interval < 一日 {
            return String(Int(interval / 一時間)) + "時間前"
        }
        
        return String(Int(interval / 一日)) + "日前"
        
    }
}
