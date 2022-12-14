//
//  GameModel.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import Foundation

struct Match: Identifiable, Codable {
    let id: UUID
    var scores: [Score] = []
    var teams: [Team] = []
    var beginDate: Date
    var endDate: Date? = nil
    
    init(teams: [Team]) {
        self.id = UUID()
        self.teams = teams
        self.beginDate = Date.now
        
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
