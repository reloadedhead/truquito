//
//  GameStore.swift
//  truquito
//
//  Created by Tomás García Gobet on 04.12.22.
//

import Foundation
import SwiftUI

class GameStore: ObservableObject {
    @Published var match: Match = Match(teams: [Team(name: "Nosotros"), Team(name: "Ellos")])
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        .appendingPathComponent("game.data")
    }
    
    static func load(completion: @escaping (Result<Match, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success(Match(teams: [Team(name: "Nosotros"), Team(name: "Ellos")])))
                    }
                    return
                }
                let match = try JSONDecoder().decode(Match.self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(match))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(match: Match, completion: @escaping ((Result<Match, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(match)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(match))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
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
