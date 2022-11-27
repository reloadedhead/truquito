//
//  TeamSettings.swift
//  truquito
//
//  Created by Tomás García Gobet on 27.11.22.
//

import SwiftUI

struct TeamSettings: View {
    @EnvironmentObject var game: TrucoGame
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

struct TeamSettings_Previews: PreviewProvider {
    static var previews: some View {
        let game = TrucoGame()
        
        TeamSettings(team: game.teams[0])
            .environmentObject(game)
    }
}
