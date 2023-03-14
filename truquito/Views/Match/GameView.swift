//
//  ContentView.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import SwiftUI

struct GameView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject private var matchManager = MatchManager.shared
    @State private var currentMatch = MatchManager.shared.currentMatch
    @State private var isSplashViewPresented = false
    @AppStorage("isSharedModeOn") private var isSharedModeOn = false
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    
    private func rotation(index: Int) -> Angle { index == 0 && isSharedModeOn ? Angle(degrees: 180) : .zero }
    private func align(scoreIn index: Int) -> Alignment { index == 0 ? .bottom : .top }
    
    var body: some View {
        ZStack(alignment: .top) {
            Toolbar()
            
            VStack(spacing: 0) {
                ForEach(Array(currentMatch.scores.enumerated()), id: \.element.id) { index, score in
                    ZStack(alignment: align(scoreIn: index)) {
                        ScoreView(for: score)
                            .rotationEffect(rotation(index: index))
                        ProgressBar(color: score.player!.color, value: score.value)
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: $isSplashViewPresented) {
            SplashView()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { matchManager.save() }
        }.onChange(of: matchManager.currentMatch) { _ in
            currentMatch = matchManager.currentMatch
        }.onAppear {
            if isFirstLaunch {
                isSplashViewPresented.toggle()
                isFirstLaunch.toggle()
            }
        }
    }
}
