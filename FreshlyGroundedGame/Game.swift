
import Foundation

class Game: ObservableObject {
    @Published var isStarted: Bool = false
    @Published var currentQuestionIndex: Int = 0
    private(set) var deck: [Card] = Deck.defaultDeck
    let howToPlay: String = "Be vulnerable. Don't judge."


    func startNewGame() {
        guard !deck.isEmpty else { return } // TODO: Handle condition and display error if deck is empty
        isStarted = true
        currentQuestionIndex = 0
        deck = Deck.defaultDeck.shuffled()
    }

    var currentQuestion: String {
        deck[currentQuestionIndex].prompt
    }

    func currentQuestionNumber() -> Int {
        return currentQuestionIndex + 1
    }

    func totalQuestionCount() -> Int {
        return deck.count
    }

    func isLastCard() -> Bool {
        return currentQuestionNumber() == deck.count
    }

    func nextCard() {
        guard !isLastCard() else {
            endGame()
            return
        }
        guard isStarted else {
            startNewGame()
            return
        }
        currentQuestionIndex += 1
    }

    func endGame() {
        isStarted = false
    }
}
