//
//  ContentView.swift
//  FreshlyGroundedGame
//
//  Created by Khalid Kamil on 12/08/2023.
//

import SwiftUI

struct ContentView: View {
    let howToPlay: String = "Be vulnerable. Don't judge."
    let questions: [Card] = Deck.defaultDeck
    let currentQuestionIndex: Int = 2

    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(radius: 5)

                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
                    .padding(16)

                Text(questions[0].prompt.uppercased())
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(40)
            }
            .padding(32)
            .aspectRatio(1.0, contentMode: .fit)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("Restart")
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("\(currentQuestionIndex)/\(questions.count)")
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        print("Next Question")
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
