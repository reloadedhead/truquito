//
//  ContentView.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import SwiftUI

struct GameView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var currentMatch: Match
    private var matchManager: MatchManager
    
    init() {
        let manager = MatchManager.shared
        self.matchManager = manager
        _currentMatch = StateObject(wrappedValue: manager.currentMatch)
    }
    
    var body: some View {
        return ZStack(alignment: .top) {
            Toolbar()
            
            VStack(spacing: 0) {
                ForEach(Array(currentMatch.scores), id: \.id) { score in
                    PlayerScore(for: score)
                }
            }
        }
        .onLongPressGesture(minimumDuration: 1) {
            matchManager.reset()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { matchManager.save() }
        }
    }
}
