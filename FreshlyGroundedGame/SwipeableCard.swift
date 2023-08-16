
import SwiftUI

struct SwipeableCard<Content: View>: View {
    let backgroundColor: Color
    @ViewBuilder let content: Content
    let completion: () -> Void

    @State private var dragAmount = CGSize.zero

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(backgroundColor)
                .shadow(radius: 5)
            content
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
            dragAmount = CGSize(width: -500, height: 0)
            completion()
        case 150...500:
            dragAmount = CGSize(width: 500, height: 0)
            completion()
        default:
            dragAmount = .zero
        }
    }
}

struct SwipeableCard_Previews: PreviewProvider {
    static var previews: some View {
        SwipeableCard(backgroundColor: .yellow) { Text("Content") } completion: {
            print("Card Dismissed")
        }
            .previewDisplayName("Swipeable Card")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
