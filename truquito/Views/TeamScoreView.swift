//
//  TeamScoreView.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import Foundation
import SwiftUI

struct TeamScoreView: View {
    var teamScore: Score
    var onScore: (Team, Int) -> Void
    var color: Color = random()
    
    func increase() { onScore(teamScore.team, 1)  }
    func decrease() { onScore(teamScore.team, -1)  }
    
    var body: some View {
        VStack {
            Text(teamScore.team.name)
                .font(.title2)
                .bold()
            Text(teamScore.value.formatted())
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

struct TeamScoreView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TeamScoreView(
                teamScore: Score(team: Team(name: "Preview")),
                onScore: { _,_ in print("Preview!") },
                color: .brown
            )
        }
    }
}
