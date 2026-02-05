import Foundation

extension Array where Element == Card {
    func highest() -> Card? {
        return self.max()
    }

    var description: String {
        return self.map { $0.description }.joined(separator: ", ")
    }
}
