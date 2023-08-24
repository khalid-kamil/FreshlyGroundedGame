//
//  CircularProgressView.swift
//  Simplify
//
//  Created by Khalid Kamil on 04/08/2023.
//

import SwiftUI

struct CircularProgressView: View {
    var value: Int
    let total: Int
    let color: Color = .white

    var progress: Double {
        switch value {
        case 0:
            return 1/10_000
        default:
            return Double(value) / Double(total)
        }
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.2), lineWidth: 4)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(color, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
        .animation(.easeInOut, value: progress)
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(value: 1, total: 10)
            .previewDisplayName("Circular Progress View")
            .previewLayout(.sizeThatFits)
            .padding()
            .frame(width: 200, height: 200)
    }
}
