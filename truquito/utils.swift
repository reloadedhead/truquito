//
//  utils.swift
//  truquito
//
//  Created by Tomás García Gobet on 04.12.22.
//

import Foundation
import SwiftUI

func random(randomOpacity: Bool = false) -> Color {
    Color(
        red: .random(in: 0...1),
        green: .random(in: 0...1),
        blue: .random(in: 0...1),
        opacity: randomOpacity ? .random(in: 0...1) : 1
    )
}
