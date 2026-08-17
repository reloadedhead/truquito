//
//  ChoosePlayerMenu.swift
//  truquito
//
//  Created by Tomás García Gobet on 19.02.23.
//

import SwiftUI
import SwiftData

struct ChoosePlayerMenu: View {
    @Query(sort: \Player.name) private var players: [Player]
    @Environment(\.colorScheme) private var colorScheme

    var match: Match
    var score: Score

    private var availablePlayers: [Player] {
        let others = Set(match.scores.filter { $0 !== score }.compactMap { $0.player })
        return players.filter { !others.contains($0) }
    }

    var body: some View {
        Picker(selection: Binding(
            get: { score.player },
            set: { score.player = $0 }
        )) {
            ForEach(availablePlayers) { player in
                Text(player.name).tag(player as Player?)
            }
        } label: {
            Text(score.player?.name ?? "Unknown")
        }
        .pickerStyle(.menu)
        .font(.title2)
        .tint(colorScheme == .dark ? .white : .black)
        .onTapGesture {}
    }
}
