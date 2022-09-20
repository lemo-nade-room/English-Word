import Foundation
import Collections

extension Array where Element: Equatable, Element: Hashable {
    var unique: Self {
        OrderedSet(self).elements
    }
}
