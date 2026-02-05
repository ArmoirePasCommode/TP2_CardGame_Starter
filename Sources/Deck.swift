import Foundation

class Deck {
    var cards: [Card] = []

    init() {
        reset()
    }

    func shuffle() {
        cards.shuffle()
    }

    func draw() -> Card? {
        return cards.isEmpty ? nil : cards.removeFirst()
    }

    func reset() {
        cards.removeAll()
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                cards.append(Card(rank: rank, suit: suit))
            }
        }
        shuffle()
    }
}
