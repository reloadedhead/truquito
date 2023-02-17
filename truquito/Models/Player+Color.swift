//
//  Player+Color.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import Foundation
import SwiftUI

extension Color {
    var hexString: String? {
        guard let components = UIColor(self).cgColor.components else { return nil }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }
}

extension Player {
    var color: Color {
        get {
            return Color(hex: self.colorString!)
        }
        set {
            self.colorString = newValue.hexString!
        }
    }
}
