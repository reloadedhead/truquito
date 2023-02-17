//
//  SettingsView.swift
//  truquito
//
//  Created by Tomás García Gobet on 27.11.22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var viewContext

    var body: some View {
        NavigationView {
            List {
                PlayerListView()
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
