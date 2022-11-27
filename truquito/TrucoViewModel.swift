//
//  TrucoViewModel.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import Foundation

class TrucoGame: ObservableObject {
    @Published private(set) var match: Match
    
    var teams: [Team] {
        get {
            match.teams
        }
        set(teams) {
            match.updateTeams(teams: teams)
        }
    }
    
    init() {
        let match = Match(teams: [Team(name: "Nosotros"), Team(name: "Ellos")])
        self.match = match
    }
    
    private let max = 30
    private let min = 0
    
    private func canScore(_ teamId: Team.ID, _ scored: Int) -> Bool {
        if let score = match.scores.first(where: { $0.teamId == teamId}) {
            return (score.value + scored <= max) && (score.value + scored >= min)
        }
        
        return false
    }
    
//    MARK: INTENT UPDATE SCORE
    
    func score(for teamId: Team.ID, _ scored: Int) -> Void {
        if (canScore(teamId, scored)) {
            match.score(for: teamId, scored)
        }
    }
    
//    MARK: GET SCORES OF TEAM
    
    func getScore(of team: Team) -> Int {
        if let teamScoreIndex = match.scores.firstIndex(where: { $0.teamId == team.id }) {
            return match.scores[teamScoreIndex].value
        }
//      TODO: Throw something here.
        return 0
    }
    
//    MARK: INTENT RESET GAME
    
    func reset() {
        match.reset()
    }
}
