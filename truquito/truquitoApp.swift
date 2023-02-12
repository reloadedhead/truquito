//
//  truquitoApp.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import SwiftUI

@main
struct truquitoApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            GameView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
