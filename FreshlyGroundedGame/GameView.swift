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
                CardView(content: game.currentQuestion)
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
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        game.nextQuestion()
                    } label: {
                        Text("Next Question")
                    }

                }
            }
            .foregroundColor(.white)
            .navigationTitle("LOGO")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
