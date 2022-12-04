//
//  TeamSettings.swift
//  truquito
//
//  Created by Tomás García Gobet on 27.11.22.
//

import SwiftUI

struct TeamSettings: View {
    @EnvironmentObject var game: GameStore
    var team: Team
    
    var teamIndex: Int {
        game.teams.firstIndex(where: { $0.id == team.id })!
    }
    
    var body: some View {
        List {
            Section("Nombre") {
                TextField("Nombre", text: $game.teams[teamIndex].name)
            }
        }
        .navigationTitle(team.name)
    }
}
