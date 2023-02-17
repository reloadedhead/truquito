//
//  PlayerSettingsView.swift
//  truquito
//
//  Created by Tomás García Gobet on 13.02.23.
//

import SwiftUI

struct PlayerSettings: View {
    @ObservedObject var player: Player
    @State private var name: String
    @Environment(\.presentationMode) var presentationMode
    
    var onDelete: (Player) -> Void
    var onSave: () -> Void
    
    init(player: Player, onDelete: @escaping (Player) -> Void, onSave: @escaping () -> Void) {
        self.player = player
        self.onSave = onSave
        self.onDelete = onDelete
        _name = State(initialValue: player.name!)
    }
    
    func handleDelete() {
        onDelete(player)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            List {
                Section("Nombre") {
                    TextField("Nombre", text: $name, onCommit: {
                        player.name = name
                    })
                }
                Button(action: { handleDelete() }) {
                    HStack {
                        Image(systemName: "trash")
                        Text("Borrar jugador")
                    }.tint(.red)
                }
            }
        
            
        }
        .navigationTitle(player.name ?? "").onDisappear { onSave() }
    }
}
