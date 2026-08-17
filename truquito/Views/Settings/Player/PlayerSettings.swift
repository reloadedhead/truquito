//
//  PlayerSettingsView.swift
//  truquito
//
//  Created by Tomás García Gobet on 13.02.23.
//

import SwiftUI
import SwiftData

struct PlayerSettings: View {
    var player: Player

    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @Query(sort: \Match.beginDate, order: .reverse) private var allMatches: [Match]

    @State private var name: String
    @State private var color: Color

    init(player: Player) {
        self.player = player
        _name = State(initialValue: player.name)
        _color = State(initialValue: player.color)
    }

    private var matches: [Match] { allMatches.filter { $0.players.contains(player) } }
    private var isPlaying: Bool { allMatches.first?.players.contains(player) ?? false }

    func handleDelete() {
        context.delete(player)
        self.presentationMode.wrappedValue.dismiss()
    }

    var body: some View {
        List {
            Section("Nombre") {
                TextField("Nombre", text: $name, onCommit: {
                    player.name = name
                })
            }
            Section("Color") {
                ColorPicker("Seleccioná un color", selection: $color, supportsOpacity: false).onChange(of: color) {
                    player.color = color
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
        .navigationTitle(player.name)
    }
}

struct PlayerSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.mainContext
        let player = try! context.fetch(FetchDescriptor<Player>(sortBy: [SortDescriptor(\.name)])).first!

        PlayerSettings(player: player)
            .modelContainer(PersistenceController.preview)
    }
}
