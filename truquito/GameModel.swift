//
//  GameModel.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import Foundation

struct Team: Identifiable, Equatable {
    let id: UUID
    var name: String
    
    init(name: String) {
        self.name = name
        self.id = UUID()
    }
}

struct Score: Identifiable, Equatable {
    let id: UUID
    let team: Team
    var value: Int
    
    init(team: Team) {
        self.id = UUID()
        self.team = team
        self.value = 0
    }
}

struct Match: Identifiable {
    let id: UUID
    var scores: [Score] = []
    var isPlaying: Bool = true
    
    init(teams: [Team]) {
        self.id = UUID()
        for team in teams {
            self.scores.append(Score(team: team))
        }
    }
    
    mutating func score(for team: Team, _ scored: Int) {
        if let scoreIndex = scores.firstIndex(where: { $0.team == team }) {
            scores[scoreIndex].value += scored
        }
    }
    
    mutating func reset() {
        self.scores = []
    }
    
    mutating func reset(withTeams teams: [Team]) {
        self.scores = []
        for team in teams {
            self.scores.append(Score(team: team))
        }
    }
}
