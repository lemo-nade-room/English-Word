import XCTest
@testable import App

final class BookTextTests: XCTestCase {
    
    func test単語の抽出() {
        let text = BookText(text: """
        they see learning a foreign language as necessary for their education or career.
        ( 2c ), two factors that receive great attention in most formal language classrooms.
        
        
            Adults usually want to learn a foreign language in a hurry, unlike children, who can devote many years to language mastery.
        Also, adults have complex communication needs (3)( ability / beyond / extend / mere / that / the ) to carry on simple conversations.
        """)
        
        let expected = ["they", "see", "learning", "a", "foreign", "language", "as", "necessary", "for", "their", "education", "or", "career", "two", "factors", "that", "receive", "great", "attention", "in", "most", "formal", "classrooms", "adults", "usually", "want", "to", "learn", "hurry", "unlike", "children", "who", "can", "devote", "many", "years", "mastery", "also", "adults", "have", "complex", "communication", "needs", "ability", "beyond", "extend", "mere", "the", "carry", "on", "simple", "conversations"]
        
        XCTAssertEqual(expected, text.extractedWords.map { $0.word })
    }
}
