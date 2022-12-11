//
//  TeamList.swift
//  truquito
//
//  Created by Tomás García Gobet on 27.11.22.
//

import SwiftUI

struct TeamList: View {
    var teams: [Team]
    var body: some View {
            Section("Equipos") {
                ForEach(teams) { team in
                    NavigationLink(destination: TeamSettings(team: team)) {
                        TeamRow(team: team)
                    }
                }
            }
    }
}

struct TeamList_Previews: PreviewProvider {
    static var previews: some View {
        TeamList(teams: [Team(name: "Nosotros"), Team(name: "Ellos")])
    }
}
