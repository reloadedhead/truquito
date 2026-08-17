//
//  Player.swift
//  truquito
//
//  Created by Tomás García Gobet on 16.02.23.
//

import Foundation
import SwiftData

@Model
final class Player {
    var name: String = ""
    var colorString: String?
    @Relationship(deleteRule: .cascade, inverse: \Score.player)
    var scoresData: [Score]? = []

    init(name: String, colorString: String? = nil) {
        self.name = name
        self.colorString = colorString
    }
}
