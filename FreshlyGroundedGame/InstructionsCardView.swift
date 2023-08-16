
import SwiftUI

struct InstructionsCardView: View {
    let content: String

    var body: some View {
        VStack {
            Text("How to play".uppercased())
                .font(.title3)
                .fontWeight(.heavy)
                .padding(.bottom, 24)
            Text(content.uppercased())
        }
        .font(.headline)
        .multilineTextAlignment(.center)
        .foregroundColor(.white)
        .padding(40)
    }
}

struct InstructionsCardView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsCardView(content: "Be vulnerable. Don't judge.")
            .frame(width: 300, height: 300)
            .previewDisplayName("Instructions Card")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .padding()
    }
}
