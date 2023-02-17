//
//  PlayerManager.swift
//  truquito
//
//  Created by Tomás García Gobet on 16.02.23.
//

import Foundation
import CoreData

class PlayerManager: ObservableObject {
    @Published var players: [Player] = []
    private let context = PersistenceController.shared.container.viewContext
    
    func fetchAll() {
        do {
            self.players = try context.fetch(Player.fetchRequest())
        } catch {
            print("Error fetching players: \(error.localizedDescription)")
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error saving player: \(error.localizedDescription)")
        }
    }
    
    func add(name: String) {
        let newPlayer = Player(context: context)
        newPlayer.name = name
        newPlayer.color = .orange
        
        self.save()
    }
    
    func delete(_ player: Player) {
        context.delete(player)
        self.save()
    }
}
