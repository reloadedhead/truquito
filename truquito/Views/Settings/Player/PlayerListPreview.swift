//
//  PlayerListView.swift
//  truquito
//
//  Created by Tomás García Gobet on 13.02.23.
//

import SwiftUI
import SwiftData

struct PlayerListPreview: View {
    @Query(sort: \Player.name) private var players: [Player]

    var body: some View {
        Section("Jugadores") {
            ForEach(players.prefix(3)) { player in
                NavigationLink(destination: PlayerSettings(player: player)) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .frame(width: 10)
                            .foregroundColor(player.color)
                        Text(player.name)
                        Spacer()
                    }
                }
            }

            NavigationLink(destination: PlayerList()) {
                Text("Ver más...")
            }
        }
    }
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListPreview()
            .modelContainer(PersistenceController.preview)
    }
}
