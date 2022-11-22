//
//  ContentView.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import SwiftUI

func random(randomOpacity: Bool = false) -> Color {
    Color(
        red: .random(in: 0...1),
        green: .random(in: 0...1),
        blue: .random(in: 0...1),
        opacity: randomOpacity ? .random(in: 0...1) : 1
    )
}

struct ContentView: View {
    @StateObject private var game = TrucoGame()
    
    let color = random()
    
    var body: some View {
        VStack {
            ForEach(game.match.scores, id: \.id) { currentTeamScore in
                TeamScoreView(
                    teamScore: currentTeamScore,
                    onScore: { game.score(for: $0, $1) },
                    color: color
                )
            }
        }.onLongPressGesture(minimumDuration: 1) {
            game.reset()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

