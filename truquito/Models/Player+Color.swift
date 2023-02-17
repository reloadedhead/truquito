//
//  Player+Color.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import Foundation
import SwiftUI

extension Color {
    static func fromString(_ string: String) -> Color {
        guard let color = UIColor(named: string) else {
            return Color.clear
        }
        return Color(color)
    }
}


extension Player {
    var color: Color {
        get {
            return Color.fromString(self.colorString ?? "#000000")
        }
        set {
            self.colorString = newValue.description
        }
    }
}
