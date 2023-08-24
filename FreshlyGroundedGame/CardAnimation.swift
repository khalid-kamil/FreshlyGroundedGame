
import SwiftUI

final class CardAnimation {
    let animation: AnimationType
    let duration: Double
    let next: CardAnimation?
    let delay: Double
    var completion: () -> Void

    init(_ animation: AnimationType = .easeInOut, duration: Double, next: CardAnimation? = nil, delay: Double = 0, completion: @escaping () -> Void) {
        self.animation = animation
        self.duration = duration
        self.next = next
        self.delay = delay
        self.completion = completion
    }

    enum AnimationType {
        case easeIn,
             easeOut,
             easeInOut,
             spring
    }

    func play() {
        switch animation {
        case .easeInOut:
            withAnimation(.easeInOut(duration: duration).delay(delay)) {
                completion()
            }
        case .easeIn:
            withAnimation(.easeIn(duration: duration).delay(delay)) {
                completion()
            }
        case .easeOut:
            withAnimation(.easeOut(duration: duration).delay(delay)) {
                completion()
            }
        case .spring:
            let interpolatedSpeed = 1 / duration
            withAnimation(.interpolatingSpring(stiffness: 30, damping: 8).speed(interpolatedSpeed).delay(delay)) {
                completion()
            }
        }

        if let nextAni = next {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                nextAni.play()
            }
        }
    }

    func playAfter(duration: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.play()
        }
    }
}
