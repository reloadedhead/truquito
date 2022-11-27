//
//  SettingsView.swift
//  truquito
//
//  Created by Tomás García Gobet on 27.11.22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var game: TrucoGame

    var body: some View {
        NavigationView {
            TeamList(teams: game.teams)
            .navigationTitle("Configuración")
            .toolbar() {
                Button(action: { dismiss() }) {
                    Text("Listo")
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(TrucoGame())
    }
}
