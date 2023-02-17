//
//  GameStore.swift
//  truquito
//
//  Created by Tomás García Gobet on 04.12.22.
//

import Foundation
import SwiftUI

class GameStore {
    var matches: [Match__DEPRECATED] = [Match__DEPRECATED(teams: [Team(name: "Ellos"), Team(name: "Nosotros")])]
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        .appendingPathComponent("game.data")
    }
    
    static func load(completion: @escaping (Result<[Match__DEPRECATED], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([Match__DEPRECATED(teams: [Team(name: "Ellos"), Team(name: "Nosotros")])]))
                    }
                    return
                }
                let matches = try JSONDecoder().decode([Match__DEPRECATED].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(matches))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(matches: [Match__DEPRECATED], completion: @escaping ((Result<[Match__DEPRECATED], Error>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(matches)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(matches))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
