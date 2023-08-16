
import SwiftUI

struct QuestionCardView: View {
    let content: String

    var body: some View {
        Text(content.uppercased())
            .font(.headline)
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            .padding(40)
    }
}

struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCardView(content: Card.example.prompt)
            .previewDisplayName("Question Card")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
