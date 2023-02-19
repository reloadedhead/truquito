//
//  Score+Init.swift
//  truquito
//
//  Created by Tomás García Gobet on 19.02.23.
//

import Foundation
import CoreData

extension Score {
    convenience init(context: NSManagedObjectContext, for player: Player) {
        self.init(context: context)
        self.player = player
    }
    
    var value: Int {
        get { Int(self.valueData) }
        set { self.valueData = Int16(newValue) }
    }
}
