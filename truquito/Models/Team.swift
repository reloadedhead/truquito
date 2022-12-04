//
//  Team.swift
//  truquito
//
//  Created by Tomás García Gobet on 28.11.22.
//

import Foundation

struct Team: Identifiable, Equatable, Codable {
    let id: UUID
    var name: String
    
    init(name: String) {
        self.name = name
        self.id = UUID()
    }
}
