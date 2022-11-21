//
//  TrucoViewModel.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import Foundation

class TrucoGame: ObservableObject {
    @Published private(set) var match: Match = Match(teams: [Team(name: "Nosotros"), Team(name: "Ellos")])
    
    private let max = 30
    private let min = 0
    
    private func canScore(for team: Team, _ scored: Int) -> Bool {
        if let score = match.scores.first(where: { $0.team == team}) {
            return (score.value + scored <= max) && (score.value + scored >= min)
        }
        
        return false
    }
    
    var teams: [Team] { match.scores.map({ $0.team }) }
    
//    MARK: INTENT UPDATE SCORE
    
    func score(for team: Team, _ scored: Int) -> Void {
        if (canScore(for: team, scored)) {
            match.score(for: team, scored)
        }
    }
    
//    MARK: GET SCORES OF TEAM
    
    func getScore(of team: Team) -> Int {
        if let teamScoreIndex = match.scores.firstIndex(where: { $0.team == team }) {
            return match.scores[teamScoreIndex].value
        }
//      TODO: Throw something here.
        return 0
    }
    
//    MARK: INTENT RESET GAME
    
    func reset() {
        match.reset(withTeams: [Team(name: "Nosotros"), Team(name: "Ellos")])
    }
}
