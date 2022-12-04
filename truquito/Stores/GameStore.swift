//
//  GameStore.swift
//  truquito
//
//  Created by Tomás García Gobet on 04.12.22.
//

import Foundation
import SwiftUI

class GameStore {
    var match: Match = Match(teams: [Team(name: "Nosotros"), Team(name: "Ellos")])
    
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
}
