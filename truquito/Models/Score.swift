//
//  Score.swift
//  truquito
//
//  Created by Tomás García Gobet on 28.11.22.
//

import Foundation

struct Score: Identifiable, Equatable {
    let id: UUID
    var teamId: UUID
    var value: Int
    
    init(for team: Team) {
        self.id = UUID()
        self.teamId = team.id
        self.value = 0
    }
}
