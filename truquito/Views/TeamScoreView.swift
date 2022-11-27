//
//  TeamScoreView.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import Foundation
import SwiftUI

struct TeamScoreView: View {
    @EnvironmentObject var game: TrucoGame
    
    var score: Score
    var onScore: (UUID, Int) -> Void
    var color: Color = random()
    
    var team: Team {
        game.teams.first(where: {$0.id == score.teamId})!
    }
    
    func increase() { onScore(team.id, 1)  }
    func decrease() { onScore(team.id, -1)  }
    
    var body: some View {
        VStack {
            Text(team.name)
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
            .background(color)
            .contentShape(Rectangle())
            .onTapGesture { increase() }
            .gesture(DragGesture(minimumDistance: 5)
                .onEnded({ _ in decrease() }))
    }
}
