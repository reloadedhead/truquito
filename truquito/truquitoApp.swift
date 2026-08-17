//
//  truquitoApp.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import SwiftUI
import SwiftData

@main
struct truquitoApp: App {
    var body: some Scene {
        WindowGroup {
            GameView()
        }
        .modelContainer(PersistenceController.shared)
    }
}
