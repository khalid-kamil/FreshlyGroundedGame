
import Foundation

class Game: ObservableObject {
    @Published var state: GameState
    @Published var currentQuestionIndex: Int
    private(set) var deck: [Card] = Deck.defaultDeck
    let howToPlay: String = "Be vulnerable. Don't judge."

    init(state: GameState = .launched, currentQuestionIndex: Int = 0, deck: [Card] = Deck.defaultDeck.shuffled()) {
        self.state = state
        self.currentQuestionIndex = currentQuestionIndex
        self.deck = deck
    }

    func startGame() {
        guard !deck.isEmpty else { return } // TODO: Handle condition and display error if deck is empty
        state = .started
    }

    func launchGame() {
        state = .launched
        currentQuestionIndex = 0
        deck = Deck.defaultDeck.shuffled()
    }

    func showInstructions() {
        state = .instructions
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
        switch state {
        case .launched:
            showInstructions()
        case .instructions:
            startGame()
        case .started:
            guard !isLastCard() else {
                endGame()
                return
            }
            currentQuestionIndex += 1
        case .finished:
            launchGame()
        }
    }

    func endGame() {
        state = .finished
    }
}

enum GameState {
    case launched
    case instructions
    case started
    case finished
}
