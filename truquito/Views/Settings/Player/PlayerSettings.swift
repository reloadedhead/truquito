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
    @State private var color: Color
    
    private var matchManager = MatchManager.shared
    
    @Environment(\.presentationMode) var presentationMode
    
    var onDelete: (Player) -> Void
    var onSave: () -> Void
    
    init(player: Player, onDelete: @escaping (Player) -> Void, onSave: @escaping () -> Void) {
        self.player = player
        self.onSave = onSave
        self.onDelete = onDelete
        _name = State(initialValue: player.name ?? "")
        _color = State(initialValue: player.color)
    }
    
    func handleDelete() {
        onDelete(player)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        let isPlaying = matchManager.isPlaying(player)
        let matches = matchManager.matches(of: player)
        
        return VStack {
            List {
                Section("Nombre") {
                    TextField("Nombre", text: $name, onCommit: {
                        player.name = name
                    })
                }
                Section("Color") {
                    ColorPicker("Seleccioná un color", selection: $color, supportsOpacity: false).onChange(of: color) { newColor in
                        player.color = newColor
                    }
                }
                
                Section("Historial") {
                    ForEach(matches.prefix(3)) { match in
                        HistoryRow(match: match, player: player)
                    }
                    
                    if matches.count > 3 {
                        NavigationLink(destination: HistoryView(matches: matches, player: player)) {
                            Text("Ver más...")
                        }
                    }
                }
            
                Button(action: { handleDelete() }) {
                    HStack {
                        Image(systemName: "trash")
                        Text("Borrar jugador")
                    }.tint(.red)
                }
                .disabled(isPlaying)
            }
        
            
        }
        .navigationTitle(player.name ?? "").onDisappear { onSave() }
    }
}

struct PlayerSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let player = PlayerManager.shared.players[0]
        
        PlayerSettings(player: player, onDelete: {_ in }, onSave: {})
    }
}
