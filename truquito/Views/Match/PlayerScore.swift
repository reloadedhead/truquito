//
//  PlayerScore.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import SwiftUI

struct PlayerScore: View {
    @ObservedObject var score: Score
    @ObservedObject var player: Player
    
    private let matchManager = MatchManager()
    
    func increase() { matchManager.score(for: score, value: 1)  }
    func decrease() { matchManager.score(for: score, value: -1) }
    
    init(for score: Score) {
        self.score = score
        self.player = score.player!
    }
    
        var body: some View {
            VStack {
            Text(player.name ?? "Unknown")
                .font(.title2)
                .bold()
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

