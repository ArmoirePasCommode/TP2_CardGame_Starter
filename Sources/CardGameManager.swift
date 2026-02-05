import Foundation

final class CardGameManager {
    static let shared = CardGameManager()

    private init() {}

    func run() {
        print("Card Game: War")
        print("=================\n")
        let player1 = HumanPlayer(name: "Sascha")
        let player2 = AIPlayer(name: "Bob")

        let game = Game(player1: player1, player2: player2)
        game.play()
    }
}
