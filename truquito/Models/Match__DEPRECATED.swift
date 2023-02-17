//
//  GameModel.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import Foundation

struct Match__DEPRECATED: Identifiable, Codable {
    let id: UUID
    var scores: [Score__DEPRECATEED] = []
    var teams: [Team] = []
    var beginDate: Date
    var endDate: Date? = nil
    
    init(teams: [Team]) {
        self.id = UUID()
        self.teams = teams
        self.beginDate = Date.now
        
        for team in teams {
            self.scores.append(Score__DEPRECATEED(for: team))
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
        self.scores = self.teams.map({ Score__DEPRECATEED(for: $0) })
    }
    
}
