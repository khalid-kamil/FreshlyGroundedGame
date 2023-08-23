
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

                Group {
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

                        SwipeableCard(backgroundColor: Color("Lead")) {
                            TitleCardView()
                        } completion: {
                            game.nextCard()
                        }
                    }
                }
            }
            .overlay(skipOverlay)
            .overlay(nextOverlay)
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

extension GameView {
    var skipOverlay: some View {
        HStack {
            ZStack(alignment: .leading) {
                Text("Skip")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .opacity(0.6)
                    .padding(.leading, 12)
                Rectangle()
                    .fill(RadialGradient(gradient: Gradient(colors: [.gray, .clear]), center: UnitPoint(x: -1, y: 0.5), startRadius: 1, endRadius: 360))
                    .frame(width: 200, height: 800)
            }
            Spacer()
        }
    }

    var nextOverlay: some View {
        HStack {
            Spacer()
            ZStack(alignment: .trailing) {
                Text("Next")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                    .opacity(0.6)
                    .padding(.trailing, 12)
                Rectangle()
                    .fill(RadialGradient(gradient: Gradient(colors: [.green, .clear]), center: UnitPoint(x: 2, y: 0.5), startRadius: 1, endRadius: 360))
                    .opacity(0.8)
                    .frame(width: 200, height: 800)
            }
        }
    }
}
