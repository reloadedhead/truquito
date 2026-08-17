//
//  Toolbar.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import SwiftUI
import SwiftData

struct Toolbar: ToolbarContent {
    var currentMatch: Match
    @Binding var isSettingsPresented: Bool

    @Environment(\.modelContext) private var context

    private func reset() {
        currentMatch.endDate = Date()
        context.insert(Match(players: currentMatch.players))
    }

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Picker(selection: Binding(
                get: { currentMatch.target },
                set: { currentMatch.target = $0 }
            )) {
                ForEach(Targets.allCases, id: \.self) { option in
                    Text("Jugar a \(option.rawValue)").tag(option.rawValue)
                }
            } label: {
                Label("\(currentMatch.target)", systemImage: "target")
            }
            .pickerStyle(.menu)
        }

        ToolbarItemGroup(placement: .topBarTrailing) {
            Button(action: reset) {
                Image(systemName: "arrow.trianglehead.counterclockwise")
            }

            Button(action: { isSettingsPresented.toggle() }) {
                Image(systemName: "gear")
            }
        }
    }
}
