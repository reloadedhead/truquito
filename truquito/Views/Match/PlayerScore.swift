//
//  PlayerScore.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import SwiftUI

struct PlayerScore: View {
    @ObservedObject var score: Score
    @Environment(\.colorScheme) private var colorScheme
    @State var isPresentingContextMenu = false
    
    private let matchManager = MatchManager.shared
    
    func increase() { matchManager.score(for: score, value: 1)  }
    func decrease() { matchManager.score(for: score, value: -1) }
    func handleSelectPlayer(_ player: Player) { matchManager.change(player, for: score) }
    
    init(for score: Score) {
        self.score = score
    }
    
    var player: Player {
          score.player!
      }
    
        var body: some View {
            VStack(alignment: .center, spacing: 0) {
                Menu(content: {
                    ChoosePlayerMenu(currentPlayer: player, onSelect: handleSelectPlayer)
                }) {
                    Text(player.name ?? "Unknown")
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
            .background(score.player!.color)
            .contentShape(Rectangle())
            .onTapGesture { increase() }
            .gesture(DragGesture(minimumDistance: 5)
                .onEnded({ _ in decrease() }))
    }
}

