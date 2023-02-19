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
        self.scoreA = Score(context: context, for: players[0])
        self.scoreB = Score(context: context, for: players[1])
    }
    
    var scores: [Score] { [self.scoreA!, self.scoreB!] }
}
