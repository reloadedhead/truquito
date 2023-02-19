//
//  PlayerListView.swift
//  truquito
//
//  Created by Tomás García Gobet on 13.02.23.
//

import SwiftUI

struct PlayerListView: View {
    @ObservedObject private var playerManager = PlayerManager()
    
    var body: some View {
        Section("Jugadores") {
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
            NavigationLink(destination: CreatePlayer())
            {
                Text("Nuevo jugador")
            }
        }.onAppear {
            playerManager.fetchPlayers()
        }
    }
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView()
    }
}
