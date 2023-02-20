//
//  ChoosePlayerMenu.swift
//  truquito
//
//  Created by Tomás García Gobet on 19.02.23.
//

import SwiftUI

struct ChoosePlayerMenu: View {
    @ObservedObject private var manager = PlayerManager()
    @ObservedObject private var matchManager = MatchManager()
    
    let currentPlayer: Player
    var onSelect: (_ player: Player) -> Void
    
    var body: some View {
        Section("Cambiar jugador") {
            ForEach(manager.players.filter { !matchManager.isPlaying($0) }) { player in
                Button(action: { onSelect(player) }) {
                    Text(player.name ?? "Unknown")
                }
            }
        }
    }
}
