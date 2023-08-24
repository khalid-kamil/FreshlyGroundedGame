
import Foundation

class Game: ObservableObject {
    @Published var state: GameState
    @Published var splashScreenState = SplashScreenState.on
    @Published var currentQuestionIndex: Int
    @Published var displayedQuestions: [Question] = []
    private(set) var fetchedQuestions: [Question] = Constants.questions
    let howToPlay: String = "Be vulnerable. Don't judge."

    var completedQuestions: Int = 0
    var skippedQuestions: Int = 0
    var currentQuestionNumber: Int = 0
    var totalQuestionsCount: Int {
        fetchedQuestions.count
    }

    init(state: GameState = .launched, currentQuestionIndex: Int = 0, deck: [Question] = Constants.questions) {
        self.state = state
        self.currentQuestionIndex = currentQuestionIndex
        self.fetchedQuestions = deck
        self.displayedQuestions = self.fetchedQuestions
        let splashAnimation = CardAnimation(.spring, duration: 1) {
            self.splashScreenState = .off
        }
        splashAnimation.playAfter(duration: 1.5)
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

    func nextCard(swipe: SwipeDirection) {
        switch state {
        case .launched:
            showInstructions()
        case .instructions:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                self?.startGame()
                self?.currentQuestionNumber += 1
            }
        case .started:
            switch swipe {
            case .left:
                skippedQuestions += 1
            case .right:
                completedQuestions += 1
            case .none:
                return
            }

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

enum SwipeDirection {
    case left
    case right
    case none
}

enum SplashScreenState {
    case on, off
}
