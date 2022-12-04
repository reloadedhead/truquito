//
//  TeamRow.swift
//  truquito
//
//  Created by Tomás García Gobet on 27.11.22.
//

import SwiftUI

struct TeamRow: View {
    var team: Team
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .frame(width: 10)
                .foregroundColor(team.color)
            Text(team.name)
            Spacer()
        }
    }
}

struct TeamRow_Previews: PreviewProvider {
    static var previews: some View {
        TeamRow(team: Team(name: "Equipo 1"))
    }
}
