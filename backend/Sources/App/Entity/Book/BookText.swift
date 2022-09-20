import Foundation
import Collections
import SwiftDeepLTranslation


struct BookText {
    
    let text: String
    
    var extractedWords: [BookWord] {
        text.components(separatedBy: CharacterSet(charactersIn: ",. \t()/'\"\n"))
            .filter { !["\n", "", "/"].contains($0) }
            .unique
            .compactMap { BookWord(word: $0) }
    }
}
