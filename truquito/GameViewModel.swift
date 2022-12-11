//
//  GameViewModel.swift
//  truquito
//
//  Created by Tomás García Gobet on 04.12.22.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published private var gameStore: GameStore
    @Published private(set) var history: [Match]
    
    var match: Match {
        get {
            self.history.last!
        } set(match) {
            history.removeLast()
            history.append(match)
        }
    }
    
    var teams: [Team] {
          get {
              match.teams
          }
          set(teams) {
              match.updateTeams(teams: teams)
          }
      }
    
    init() {
        let gameStore = GameStore()
        self.gameStore = gameStore
        self.history = gameStore.matches
    }
    
    func load() {
        GameStore.load { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let matches):
                self.match = matches.first!
                self.history = matches
            }
        }
    }
    
    func save() {
        GameStore.save(matches: self.history) { result in
            if case .failure(let error) = result {
                fatalError(error.localizedDescription)
            }
        }
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
        self.match.endDate = Date.now
        
        let newMatch = Match(teams: self.match.teams)
        self.history.append(newMatch)
    }
    
//    MARK: INTENT DELETE HISTORY
    
    func removeHistory(atOffsets: IndexSet) {
        self.history.remove(atOffsets: atOffsets)
    }
}
