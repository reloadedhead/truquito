//
//  Player+Color.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import Foundation
import SwiftUI
import CoreData

extension Player {
    convenience init(context: NSManagedObjectContext, name: String, color: Color) {
        self.init(context: context)
        self.name = name
        self.color = color
    }
    
    var color: Color {
        get {
            return Color(hex: self.colorString!)
        }
        set {
            self.colorString = newValue.hexValue!
        }
    }
}
