//
//  ContentView.swift
//  FreshlyGroundedGame
//
//  Created by Khalid Kamil on 12/08/2023.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game = Game()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color("Inside"), Color("Oregon Grape")], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                GameOverCardView()
                ForEach(game.deck, id: \.self) { question in
                    SwipeableCard(backgroundColor: .white) {
                        QuestionCardView(content: question.prompt)
                    } completion: {
                        game.nextQuestion()
                    }
                }
                SwipeableCard(backgroundColor: Color("Lead")) {
                    TitleCardView()
                } completion: {
                    game.nextQuestion()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        game.startNewGame()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("\(game.currentQuestionNumber())/\(game.totalQuestionCount())")
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
