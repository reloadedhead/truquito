//
//  ContentView.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import SwiftUI

struct GameView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject private var game = GameViewModel()
    
    private let matchManager = MatchManager()
    
    func initialLoad() {
        game.load()
        matchManager.fetch()
    }
    
    let color = random()
    
    var body: some View {
        ZStack(alignment: .top) {
            Toolbar()
            
            VStack(spacing: 0) {
                ForEach(game.match.scores, id: \.id) { currentTeamScore in
                    TeamScoreView(score: currentTeamScore) {
                        game.score(for: $0, $1)
                    }
                }.environmentObject(game)
            }
        }
        .onLongPressGesture(minimumDuration: 1) {
            game.reset()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { game.save() }
        }
        .onAppear { initialLoad() }
    }
}
