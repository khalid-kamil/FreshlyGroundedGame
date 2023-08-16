
import SwiftUI

struct GameView: View {
    @ObservedObject var game = Game()
    var showStartMenu: Bool {
        return game.state == .launched || game.state == .instructions
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color("Inside"), Color("Oregon Grape")], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()

                GameOverCardView(completed: game.completedQuestions) { game.launchGame() }

                ForEach(game.displayedQuestions.reversed()) { question in
                    SwipeableCard(backgroundColor: .white) {
                        QuestionCardView(content: question.prompt)
                    } completion: {
                        game.nextCard()
                    }
                }

                if showStartMenu {
                    SwipeableCard(backgroundColor: Color("Lead")) {
                        InstructionsCardView(content: game.howToPlay)
                    } completion: {
                        game.nextCard()
                    }
                    .animation(.easeOut(duration: 1), value: showStartMenu)

                    SwipeableCard(backgroundColor: Color("Lead")) {
                        TitleCardView()
                    } completion: {
                        game.nextCard()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        game.startGame()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    .scaleEffect(game.state == .started ? 1 : 0.5)
                    .opacity(game.state == .started ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 100, damping: 10), value: game.state == .started)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("\(game.currentQuestionNumber)/\(game.totalQuestionsCount)")
                        .scaleEffect(game.state == .started ? 1 : 0.5)
                        .opacity(game.state == .started ? 1 : 0)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 10), value: game.state == .started)
                }
                ToolbarItem(placement: .principal) {
                    FGLogo()
                        .frame(width: 80)
                }
            }
            .foregroundColor(.white)
            .navigationTitle("LOGO")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
        }

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
