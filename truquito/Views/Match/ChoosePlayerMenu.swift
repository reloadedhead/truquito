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

    var match: Match
    var onSelect: (_ player: Player) -> Void

    var body: some View {
        Section("Cambiar jugador") {
            ForEach(players.filter { player in !match.scores.contains { $0.player == player } }) { player in
                Button(action: { onSelect(player) }) {
                    Text(player.name)
                }
            }
        }
    }
}
