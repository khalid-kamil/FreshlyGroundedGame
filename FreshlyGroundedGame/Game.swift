
import Foundation

class Game: ObservableObject {
    @Published var state: GameState
    @Published var currentQuestionIndex: Int
    @Published var displayedQuestions: [Question] = []
    private(set) var fetchedQuestions: [Question] = Deck.defaultDeck
    let howToPlay: String = "Be vulnerable. Don't judge."

    var completedQuestions: Int = 0
    var currentQuestionNumber: Int = 0
    var totalQuestionsCount: Int {
        fetchedQuestions.count
    }

    init(state: GameState = .launched, currentQuestionIndex: Int = 0, deck: [Question] = Deck.defaultDeck) {
        self.state = state
        self.currentQuestionIndex = currentQuestionIndex
        self.fetchedQuestions = deck
        self.displayedQuestions = self.fetchedQuestions
    }

    func startGame() {
        guard !displayedQuestions.isEmpty else { return } // TODO: Handle condition and display error if deck is empty
        state = .started
    }

    func launchGame() {
        state = .launched
        currentQuestionNumber = 0
        completedQuestions = 0
        displayedQuestions = fetchedQuestions
    }

    func showInstructions() {
        state = .instructions
    }

    func isLastCard() -> Bool {
        return displayedQuestions.count == 1
    }

    func nextCard() {
        switch state {
        case .launched:
            showInstructions()
        case .instructions:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                self?.startGame()
                self?.currentQuestionNumber += 1
            }
        case .started:
            completedQuestions += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                if let _ = self?.displayedQuestions.first {
                    self?.displayedQuestions.removeFirst()
                    self?.currentQuestionNumber += 1
                }
            }
            if isLastCard() {
                endGame()
            }
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
