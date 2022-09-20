import Foundation

fileprivate extension Character {
    
    var isStrictLowercase: Bool {
        97...122 ~= (asciiValue ?? 0)
    }
    
    var isStrictUppercase: Bool {
        65...90 ~= (asciiValue ?? 0)
    }
    
    var isStrictAlphabet: Bool {
        isStrictLowercase || isStrictUppercase
    }
}

fileprivate extension String {
    var isEnglishWord: Bool {
        allSatisfy { $0.isStrictAlphabet }
    }
    
    var isAllStrictLowercase: Bool {
        allSatisfy { $0.isStrictLowercase }
    }
    
    var englishWord: String? {
        guard
            isEnglishWord,
            count != 0
        else {
            return nil
        }
        
        guard
            count != 1,
            self[startIndex].isStrictUppercase,
            String(dropFirst()).isAllStrictLowercase
        else {
            return self
        }
        return lowercased()
    }
}

struct BookWord: Equatable, Hashable {
    
    var word: String
    
    init?(word: String) {
        guard let word = word.englishWord else {
            return nil
        }
        self.word = word
    }
    
}
