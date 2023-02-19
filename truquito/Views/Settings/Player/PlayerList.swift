//
//  PlayerList.swift
//  truquito
//
//  Created by Tomás García Gobet on 19.02.23.
//

import SwiftUI

struct PlayerList: View {
    @ObservedObject private var playerManager: PlayerManager
    
    init(managedBy manager: PlayerManager) {
        self.playerManager = manager
    }
    
    var body: some View {
        List {
            ForEach(playerManager.players) { player in
                NavigationLink(destination: PlayerSettings(
                    player: player,
                    onDelete: playerManager.delete,
                    onSave: playerManager.save))
                {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .frame(width: 10)
                            .foregroundColor(player.color)
                        Text(player.name ?? "Unknown")
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Jugadores")
        .toolbar {
            NavigationLink(destination: CreatePlayer()) {
                Image(systemName: "plus")
            }
        }
        .onAppear { playerManager.fetchPlayers() }
    }
}
