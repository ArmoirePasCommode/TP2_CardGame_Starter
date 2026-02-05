import Foundation

protocol Player: AnyObject {
    var name: String { get }
    var hand: [Card] { get set }
    var score: Int { get set }

    func playCard() -> Card?
    func receiveCard(_ card: Card)
}
extension Player {
    func receiveCard(_ card: Card) {
        hand.append(card)
    }
}
class HumanPlayer: Player {
    let name: String
    var hand: [Card] = []
    var score: Int = 0

    init(name: String) {
        self.name = name
    }

    func playCard() -> Card? {
        return hand.isEmpty ? nil : hand.removeFirst()
    }
}
class AIPlayer: Player {
    let name: String
    var hand: [Card] = []
    var score: Int = 0

    init(name: String) {
        self.name = name
    }

    func playCard() -> Card? {
        return hand.isEmpty ? nil : hand.removeFirst()
    }
}
