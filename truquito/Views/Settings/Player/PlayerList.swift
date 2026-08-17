//
//  PlayerList.swift
//  truquito
//
//  Created by Tomás García Gobet on 19.02.23.
//

import SwiftUI
import SwiftData

struct PlayerList: View {
    @Query(sort: \Player.name) private var players: [Player]

    var body: some View {
        List {
            ForEach(players) { player in
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
        }
        .navigationTitle("Jugadores")
        .toolbar {
            NavigationLink(destination: CreatePlayer()) {
                Image(systemName: "plus")
            }
        }
    }
}
