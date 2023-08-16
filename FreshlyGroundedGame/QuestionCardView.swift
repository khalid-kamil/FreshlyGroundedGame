//
//  CardView.swift
//  FreshlyGroundedGame
//
//  Created by Khalid Kamil on 15/08/2023.
//

import SwiftUI

struct QuestionCardView: View {
    let content: String

    @State private var dragAmount = CGSize.zero

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(radius: 5)

            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
                .padding(16)

            Text(content.uppercased())
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(40)
        }
        .padding(32)
        .aspectRatio(1.0, contentMode: .fit)
        .offset(x: dragAmount.width, y: dragAmount.height * 0.3)
        .rotationEffect(.degrees(Double(dragAmount.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded({ _ in
                    swipeCard(width: dragAmount.width)
                })
        )
        .animation(.spring(), value: dragAmount)
    }

    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            print("Card skipped")
            dragAmount = CGSize(width: -500, height: 0)
        case 150...500:
            print("Card answered")
            dragAmount = CGSize(width: 500, height: 0)
        default:
            dragAmount = .zero
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCardView(content: Card.example.prompt)
            .previewDisplayName("Question Card")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
