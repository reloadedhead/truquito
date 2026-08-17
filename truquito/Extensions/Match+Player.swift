//
//  Match+Player.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import Foundation

extension Match {
    convenience init(players: [Player]) {
        self.init()

        self.scoreData = [
            Score(position: 0, player: players[0]),
            Score(position: 1, player: players[1])
        ]
    }

    var scores: [Score] {
        get { (scoreData ?? []).sorted { $0.position < $1.position } }
        set { scoreData = newValue }
    }

    var players: [Player] { self.scores.compactMap { $0.player } }
}
