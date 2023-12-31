
import SwiftUI

struct GameView: View {
    @ObservedObject var game = Game()
    var showStartMenu: Bool {
        return game.state == .launched || game.state == .instructions
    }
    @State var swipeDirection: SwipeDirection = .none

    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 6)
                Color.purple
                    .opacity(0.3)
                    .ignoresSafeArea()

                cardDeck
                    .scaleEffect(game.splashScreenState == .on ? 0 : 1)
                    .animation(.interpolatingSpring(stiffness: 20, damping: 5), value: game.splashScreenState)
            }
            .overlay(nextOverlay)
            .overlay(skipOverlay)
            .animation(.spring(), value: swipeDirection)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CircularProgressView(value: game.currentQuestionNumber, total: game.totalQuestionsCount)
                        .scaleEffect(game.state == .started ? 1 : 0.5)
                        .frame(width: 32)
                        .opacity(game.state == .started ? 1 : 0)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 10), value: game.state == .started)
                }
                ToolbarItem(placement: .principal) {
                    Image("FGLogo")
                        .resizable()
                        .scaledToFit()
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

extension GameView {
    var cardDeck: some View {
        ZStack {
            GameOverCardView(completed: game.completedQuestions, skipped: game.skippedQuestions) { game.launchGame() }

            ForEach(game.displayedQuestions.reversed()) { question in
                SwipeableCard(backgroundColor: .white, direction: $swipeDirection) {
                    QuestionCardView(content: question.prompt)
                        .blur(radius: swipeDirection != .none ? 4 : 0)
                } completion: { direction in
                    game.nextCard(swipe: direction)
                }
            }

            if showStartMenu {
                SwipeableCard(backgroundColor: Color("Lead"), direction: $swipeDirection) {
                    InstructionsCardView(content: game.howToPlay)
                        .blur(radius: swipeDirection != .none ? 4 : 0)
                } completion: { direction in
                    game.nextCard(swipe: direction)
                }

                SwipeableCard(backgroundColor: Color("Lead"), direction: .constant(.none)) {
                    TitleCardView()
                        .blur(radius: swipeDirection != .none ? 4 : 0)
                } completion: { direction in
                    game.nextCard(swipe: direction)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

extension GameView {
    var skipOverlay: some View {
        HStack {
            ZStack(alignment: .leading) {
                Text("Skip")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .padding(.leading, 12)
                Rectangle()
                    .fill(RadialGradient(gradient: Gradient(colors: [.gray, .clear]), center: UnitPoint(x: -1, y: 0.5), startRadius: 1, endRadius: 360))
                    .opacity(0.8)
                    .frame(width: 200, height: 800)
            }

                Spacer()
        }
        .opacity(swipeDirection == .left ? 1 : 0)
        .frame(width: UIScreen.main.bounds.width)
    }

    var nextOverlay: some View {
        HStack {
            Spacer()
            ZStack(alignment: .trailing) {
                Text("Next")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                    .padding(.trailing, 12)
                Rectangle()
                    .fill(RadialGradient(gradient: Gradient(colors: [.green, .clear]), center: UnitPoint(x: 2, y: 0.5), startRadius: 1, endRadius: 360))
                    .opacity(0.8)
                    .frame(width: 200, height: 800)
            }
        }
        .opacity(swipeDirection == .right ? 1 : 0)
        .frame(width: UIScreen.main.bounds.width)
    }
}
