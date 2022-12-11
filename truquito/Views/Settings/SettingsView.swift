//
//  SettingsView.swift
//  truquito
//
//  Created by Tomás García Gobet on 27.11.22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var game: GameViewModel

    var body: some View {
        NavigationView {
            List {
                TeamList(teams: game.teams)
                LogList(matches: game.history
                    .sorted { $0.endDate ?? $0.beginDate > $01.endDate ?? $01.beginDate }
                    .filter { $0.endDate != nil }
                )
            }
            .navigationTitle("Configuración")
            .toolbar() {
                Button(action: { dismiss() }) {
                    Text("Listo")
                }
            }
        }
    }
}
