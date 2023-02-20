//
//  MatchManager.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import Foundation
import CoreData

class MatchManager: ObservableObject {
    @Published var matches: [Match]
    @Published var currentMatch: Match
    
    static let shared = MatchManager()
    
    private var playerManager = PlayerManager.shared
    
    private let context = PersistenceController.shared.container.viewContext
    
    private init() {        
        let request: NSFetchRequest<Match> = Match.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "beginDate", ascending: false)]
        
        let results = try? context.fetch(request)
        
        if results != nil && !results!.isEmpty {
            self.matches = results!
            self.currentMatch = results![0]
        } else {
            self.matches = []
            self.currentMatch = Match(context: context, players: Array(self.playerManager.players[..<2]))
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error saving player: \(error.localizedDescription)")
        }
    }
    
    private func canScore(_ currentScore: Int, _ addition: Int) -> Bool {
        currentScore + addition >= 0 && currentScore + addition <= 30
        
    }
    
    func score(for score: Score, value: Int) {
        if canScore(score.value, value) {
            score.value += value
            save()
        }
    }
    
    func change(_ player: Player, for score: Score) {
        if let scoreIndex = currentMatch.scores.firstIndex(of: score) {
            let scores = currentMatch.scores
            scores[scoreIndex].player = player
            currentMatch.scores = scores
            save()
        }
    }

    
    func isPlaying(_ player: Player) -> Bool {
        return currentMatch.scores.first { $0.player == player } != nil
    }
    
    func reset() {
        currentMatch.endDate = Date()
        self.currentMatch = Match(context: context, players: Array(self.playerManager.players[..<2]))
        
        save()
    }
}
