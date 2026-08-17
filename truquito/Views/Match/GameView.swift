//
//  ContentView.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import SwiftUI
import SwiftData

struct GameView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Match.beginDate, order: .reverse) private var matches: [Match]
    @Query(sort: \Player.name) private var players: [Player]

    @State private var isSplashViewPresented = false
    @AppStorage("isSharedModeOn") private var isSharedModeOn = false
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true

    private func rotation(index: Int) -> Angle { index == 0 && isSharedModeOn ? Angle(degrees: 180) : .zero }
    private func align(scoreIn index: Int) -> Alignment { index == 0 ? .bottom : .top }

    var body: some View {
        Group {
            if let currentMatch = matches.first {
                ZStack(alignment: .top) {
                    Toolbar(currentMatch: currentMatch)

                    VStack(spacing: 0) {
                        ForEach(Array(currentMatch.scores.enumerated()), id: \.element.id) { index, score in
                            ZStack(alignment: align(scoreIn: index)) {
                                ScoreView(for: score)
                                    .rotationEffect(rotation(index: index))
                                ProgressBar(color: score.player?.color ?? .gray, value: score.value, target: currentMatch.target)
                            }
                        }
                    }.edgesIgnoringSafeArea(.all)
                }
            }
        }
        .sheet(isPresented: $isSplashViewPresented) {
            SplashView()
        }
        .onAppear {
            seedIfNeeded()

            if isFirstLaunch {
                isSplashViewPresented.toggle()
                isFirstLaunch.toggle()
            }
        }
    }

    private func seedIfNeeded() {
        guard matches.isEmpty else { return }

        let matchPlayers: [Player]
        if players.count >= 2 {
            matchPlayers = Array(players.prefix(2))
        } else {
            let playerA = Player(name: "Nosotros", color: .blue)
            let playerB = Player(name: "Ellos", color: .yellow)
            context.insert(playerA)
            context.insert(playerB)
            matchPlayers = [playerA, playerB]
        }

        context.insert(Match(players: matchPlayers))
    }
}
