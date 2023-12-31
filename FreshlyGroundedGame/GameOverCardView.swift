
import SwiftUI

struct GameOverCardView: View {
    let completed: Int
    let skipped: Int
    let action: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("Lead"))
                .shadow(radius: 5)

            VStack {
                Spacer()
                Text("Finished!".uppercased())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Spacer()
                Text("Skipped: \(skipped)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Text("Completed: \(completed)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Spacer()
                Spacer()
                Button {
                    // TODO: Play again
                    action()
                } label: {
                    Text("Tap to play again".uppercased())
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                        .multilineTextAlignment(.center)
                }

                // TODO: Add animation to play again
                Spacer()
            }
            .foregroundColor(.white)
            .padding(40)


        }
        .padding(32)
        .aspectRatio(1.0, contentMode: .fit)
    }
}

struct GameOverCardView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverCardView(completed: 2, skipped: 2) {
            print("Restart Game")
        }
    }
}
