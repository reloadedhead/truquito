//
//  Match+Player.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import Foundation
import CoreData

extension Match {
    convenience init(context: NSManagedObjectContext, players: [Player]) {
        self.init(context: context)
        
        self.beginDate = Date()
        self.endDate = nil
        self.scoreData = NSOrderedSet(array: [
            Score(context: context, for: players[0]),
            Score(context: context, for: players[1])
        ])
    }
    
    var target: Int {
        get { Int(self.targetData) }
        set { self.targetData = Int16(newValue) }
    }
    
    var scores: [Score] {
        get {
            if let scores = self.scoreData {
               return scores.array as? [Score] ?? []
            } else { return [] as [Score] }
        } set {
            self.scoreData = NSOrderedSet(array: newValue)
        }
    }
    
    var players: [Player] { self.scores.map { $0.player! } }
}
