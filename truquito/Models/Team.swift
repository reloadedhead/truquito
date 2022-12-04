//
//  Team.swift
//  truquito
//
//  Created by Tomás García Gobet on 28.11.22.
//

import Foundation
import SwiftUI

struct Team: Identifiable, Equatable, Codable {
    let id: UUID
    var name: String
    var color: Color
    
    init(name: String, color: Color = random()) {
        self.name = name
        self.color = color
        self.id = UUID()
    }
}
