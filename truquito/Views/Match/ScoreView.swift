//
//  PlayerScore.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import SwiftUI

struct ScoreView: View {
    var score: Score
    @Environment(\.colorScheme) private var colorScheme

    init(for score: Score) {
        self.score = score
    }

    private func canScore(_ addition: Int) -> Bool {
        guard let target = score.match?.target else { return false }
        let newValue = score.value + addition
        return newValue >= 0 && newValue <= target
    }

    private func increase() { if canScore(1) { score.value += 1 } }
    private func decrease() { if canScore(-1) { score.value -= 1 } }

    var body: some View {
        let player = score.player

        return VStack(alignment: .center, spacing: 0) {
            Menu(content: {
                if let match = score.match {
                    ChoosePlayerMenu(match: match, onSelect: { score.player = $0 })
                }
            }) {
                Text(player?.name ?? "Unknown")
                    .font(.title2)
                    .opacity(0.5)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.clear)
                            .background(BlurView(style: .systemThinMaterial).cornerRadius(14))
                    )
            }
            .tint(colorScheme == .dark ? .white : .black)
            .onTapGesture {}

            Text(score.value.formatted())
                .font(.system(size: 92, design: .monospaced))
                .bold().scaledToFit()
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity
            )
            .background(player?.color ?? .gray)
            .contentShape(Rectangle())
            .onTapGesture { increase() }
            .gesture(DragGesture(minimumDistance: 5)
                .onEnded({ _ in decrease() }))
    }
}
