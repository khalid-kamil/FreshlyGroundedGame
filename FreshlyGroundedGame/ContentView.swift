//
//  ContentView.swift
//  FreshlyGroundedGame
//
//  Created by Khalid Kamil on 12/08/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game = Game()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color("Inside"), Color("Oregon Grape")], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(radius: 5)

                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                        .padding(16)

                    Text(game.currentQuestion.uppercased())
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(40)
                }
                .padding(32)
                .aspectRatio(1.0, contentMode: .fit)

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
            .navigationTitle("LOGO")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
