//
//  Score.swift
//  truquito
//
//  Created by Tomás García Gobet on 19.02.23.
//

import Foundation
import SwiftData

@Model
final class Score {
    var value: Int = 0
    var position: Int = 0
    var match: Match?
    var player: Player?

    init(value: Int = 0, position: Int = 0, player: Player? = nil) {
        self.value = value
        self.position = position
        self.player = player
    }
}
