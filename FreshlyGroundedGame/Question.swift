
import Foundation

struct Deck {
    let cards: [Question]
}

struct Question: Identifiable {
    let id = UUID()
    let prompt: String
}
