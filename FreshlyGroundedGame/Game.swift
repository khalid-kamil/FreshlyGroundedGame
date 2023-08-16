
import Foundation

class Game: ObservableObject {
    @Published var state: GameState
    @Published var currentQuestionIndex: Int
    @Published var displayedQuestions: [Question]?
    private(set) var fetchedQuestions: [Question] = Deck.defaultDeck
    let howToPlay: String = "Be vulnerable. Don't judge."

    var completedQuestions: Int = 0

    init(state: GameState = .launched, currentQuestionIndex: Int = 0, deck: [Question] = Deck.defaultDeck.shuffled()) {
        self.state = state
        self.currentQuestionIndex = currentQuestionIndex
        self.fetchedQuestions = deck
        displayedQuestions = fetchedQuestions
    }

    func getIndex(question: Question) -> Int {
        let index = displayedQuestions?.firstIndex(where: { currentQuestion in
            return question.id == currentQuestion.id
        }) ?? 0
        return index
    }

    func startGame() {
        guard !fetchedQuestions.isEmpty else { return } // TODO: Handle condition and display error if deck is empty
        state = .started
    }

    func launchGame() {
        state = .launched
        currentQuestionIndex = 0
        completedQuestions = 0
        fetchedQuestions = Deck.defaultDeck.shuffled()
    }

    func showInstructions() {
        state = .instructions
    }

    var currentQuestion: String {
        fetchedQuestions[currentQuestionIndex].prompt
    }

    func currentQuestionNumber() -> Int {
        return currentQuestionIndex + 1
    }

    func totalQuestionCount() -> Int {
        return fetchedQuestions.count
    }

    func isLastCard() -> Bool {
        return currentQuestionNumber() == fetchedQuestions.count
    }

    func nextCard() {
        switch state {
        case .launched:
            showInstructions()
        case .instructions:
            startGame()
        case .started:
            completedQuestions += 1
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
