//
//  CreatePlayer.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import SwiftUI

struct CreatePlayer: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String = ""
    @State private var color: Color = .orange

    func handleSave() {
        let player = Player(name: name, color: color)
        context.insert(player)

        self.presentationMode.wrappedValue.dismiss()
    }

    var body: some View {
        VStack {
            List {
                Section("Nombre") {
                    TextField("Nombre", text: $name)
                }
                Section("Color") {
                    ColorPicker("Seleccioná un color", selection: $color, supportsOpacity: false)
                }
            }


        }
        .navigationTitle(name.isEmpty ? "Nuevo jugador" : name).toolbar {
            Button("Agregar") { handleSave() }
                .disabled(name.isEmpty)
        }
    }
}
