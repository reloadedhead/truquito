//
//  ContentView.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import SwiftUI

struct GameView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @ObservedObject private var matchManager = MatchManager.shared
    @ObservedObject private var currentMatch = MatchManager.shared.currentMatch
    
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
