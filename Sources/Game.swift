import Foundation

class Game {
    let player1: Player
    let player2: Player
    let deck: Deck

    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
        self.deck = Deck()
    }

    func dealCards() {
        print("Dealing cards...")
        deck.shuffle()

        while let card1 = deck.draw() {
            player1.receiveCard(card1)
            if let card2 = deck.draw() {
                player2.receiveCard(card2)
            }
        }

        print("\(player1.name) received \(player1.hand.count) cards")
        print("\(player2.name) received \(player2.hand.count) cards")
        print("")
    }

    func playRound(roundNumber: Int) {
        print("--- Round \(roundNumber) ---")

        guard let card1 = player1.playCard(),
            let card2 = player2.playCard()
        else {
            return
        }

        print("\(player1.name) plays: \(card1.description)")
        print("\(player2.name) plays: \(card2.description)")

        var pool: [Card] = [card1, card2]

        resolveRound(card1: card1, card2: card2, pool: &pool)

        print("Score: \(player1.name) \(player1.score) - \(player2.name) \(player2.score)")
        print("")
    }

    private func resolveRound(card1: Card, card2: Card, pool: inout [Card]) {
        if card1.rank > card2.rank {
            print("\(player1.name) wins this round!")
            player1.score += 1
        } else if card2.rank > card1.rank {
            print("\(player2.name) wins this round!")
            player2.score += 1
        } else {
            print("War! Each player plays 3 cards...")
            if player1.hand.count < 4 || player2.hand.count < 4 {
                if player1.hand.count < 4 && player2.hand.count >= 4 {
                    print(
                        "\(player1.name) doesn't have enough cards for War. \(player2.name) wins!")
                    player1.hand.removeAll()
                } else if player2.hand.count < 4 && player1.hand.count >= 4 {
                    print(
                        "\(player2.name) doesn't have enough cards for War. \(player1.name) wins!")
                    player2.hand.removeAll()
                } else {
                    print("Both players don't have enough cards. It's a draw!")
                    player1.hand.removeAll()
                    player2.hand.removeAll()
                }
                return
            }
            for _ in 0..<3 {
                if let c1 = player1.playCard() { pool.append(c1) }
                if let c2 = player2.playCard() { pool.append(c2) }
            }
            guard let warCard1 = player1.playCard(),
                let warCard2 = player2.playCard()
            else {
                return
            }

            print("\(player1.name) plays: \(warCard1.description)")
            print("\(player2.name) plays: \(warCard2.description)")

            pool.append(warCard1)
            pool.append(warCard2)

            if warCard1.rank > warCard2.rank {
                print("\(player1.name) wins the war!")
                player1.score += 1
            } else if warCard2.rank > warCard1.rank {
                print("\(player2.name) wins the war!")
                player2.score += 1
            } else {
                resolveRound(card1: warCard1, card2: warCard2, pool: &pool)
            }
        }
    }

    func play() {
        dealCards()

        var round = 1
        while !player1.hand.isEmpty && !player2.hand.isEmpty {
            playRound(roundNumber: round)
            round += 1
        }

        print("=== GAME OVER ===")
        print(
            "Winner: \(player1.score > player2.score ? player1.name : (player2.score > player1.score ? player2.name : "Draw")) with \(max(player1.score, player2.score)) points!"
        )
        print("Final score: \(player1.name) \(player1.score) - \(player2.name) \(player2.score)")
    }
}
