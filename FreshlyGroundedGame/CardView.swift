//
//  CardView.swift
//  FreshlyGroundedGame
//
//  Created by Khalid Kamil on 15/08/2023.
//

import SwiftUI

struct CardView: View {
    let content: String

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
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(content: Card.example.prompt)
            .previewDisplayName("Question Card")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
