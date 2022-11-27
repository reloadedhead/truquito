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
    var teamId: UUID
    var value: Int
    
    init(for team: Team) {
        self.id = UUID()
        self.teamId = team.id
        self.value = 0
    }
}

struct Match: Identifiable {
    let id: UUID
    var scores: [Score] = []
    var teams: [Team] = []
    var isPlaying: Bool = true
    
    init(teams: [Team]) {
        self.id = UUID()
        self.teams = teams
        for team in teams {
            self.scores.append(Score(for: team))
        }
    }
    
    mutating func updateTeams(teams: [Team]) {
        self.teams = teams
    }
    
    mutating func score(for teamId: Team.ID, _ scored: Int) {
        if let scoreIndex = scores.firstIndex(where: { $0.teamId == teamId }) {
            scores[scoreIndex].value += scored
        }
    }
    
    mutating func reset() {
        self.scores = self.teams.map({ Score(for: $0) })
    }
    
}
