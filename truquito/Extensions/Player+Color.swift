//
//  Player+Color.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import Foundation
import SwiftUI

extension Player {
    convenience init(name: String, color: Color) {
        self.init(name: name, colorString: color.hexValue)
    }

    var color: Color {
        get { Color(hex: colorString ?? "") }
        set { colorString = newValue.hexValue }
    }
}
