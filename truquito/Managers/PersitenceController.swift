//
//  PersitenceController.swift
//  truquito
//
//  Created by Tomás García Gobet on 12.02.23.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentCloudKitContainer
    
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        let playerA = Player(context: controller.container.viewContext)
        playerA.name = "Nosotros"
        
        let playerB = Player(context: controller.container.viewContext)
        playerA.name = "Ellos"
        
        return controller
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "truquito")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context!")
            }
        }
    }
}
