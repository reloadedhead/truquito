//
//  ProgressBar.swift
//  truquito
//
//  Created by Tomás García Gobet on 14.03.23.
//

import SwiftUI

struct ProgressBar: View {
    var color: Color
    var value: Int
    var target: Int

    var body: some View {
        let percentage = Double(value) / Double(target)

        return GeometryReader { geometry in
            if #available(iOS 26.0, *) {
                Capsule()
                    .fill(color)
                    .frame(width: geometry.size.width * CGFloat(percentage))
                    .glassEffect(.regular.tint(color), in: Capsule())
                    .overlay(
                        Capsule().strokeBorder(.white.opacity(0.6), lineWidth: 1.5)
                    )
                    .shadow(color: .black.opacity(0.25), radius: 6, y: 3)
                    .animation(.linear, value: percentage)
            } else {
                Rectangle()
                    .foregroundColor(color)
                    .shadow(color: color, radius: 10)
                    .frame(width: geometry.size.width * CGFloat(percentage) )
                    .animation(.linear, value: percentage)
                    .blendMode(.multiply)
            }
        }
        .frame(height: 20)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.red
            ProgressBar(color: .red, value: 15, target: 30)
        }
    }
}
