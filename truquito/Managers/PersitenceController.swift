//
//  PersitenceController.swift
//  truquito
//
//  Created by Tomás García Gobet on 12.02.23.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
enum PersistenceController {
    static let shared = makeContainer(inMemory: false)
    static let preview = makePreviewContainer()

    private static func makeContainer(inMemory: Bool) -> ModelContainer {
        // To enable CloudKit sync, add the iCloud/CloudKit capability in Signing & Capabilities
        // (which provisions the container for this target's bundle ID), then pass
        // cloudKitDatabase: .automatic here.
        let schema = Schema([Player.self, Match.self, Score.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Error: \(error.localizedDescription)")
        }
    }

    private static func makePreviewContainer() -> ModelContainer {
        let container = makeContainer(inMemory: true)
        let context = container.mainContext

        let playerA = Player(name: "Nosotros", color: .blue)
        let playerB = Player(name: "Ellos", color: .yellow)
        context.insert(playerA)
        context.insert(playerB)

        let finishedMatch = Match(players: [playerA, playerB])
        finishedMatch.beginDate = Date(timeIntervalSinceNow: -1200)
        finishedMatch.endDate = Date()
        context.insert(finishedMatch)

        let currentMatch = Match(players: [playerA, playerB])
        context.insert(currentMatch)

        return container
    }
}
