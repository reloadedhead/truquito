//
//  Filter.swift
//  truquito
//
//  Created by Tomás García Gobet on 15.03.23.
//

import Foundation

protocol Criteria {
    func check(_ match: Match) -> Bool
}

struct WonFilter: Criteria {
    private let player: Player
    
    init(_ player: Player) {
        self.player = player
    }
    
    func check(_ match: Match) -> Bool {
        match.scores.contains(where: { score in
            score.player == self.player && score.value == match.target
        })
    }
}

struct LostFilter: Criteria {
    private let player: Player
    private let abandonedFilter: AbandonedFilter
    
    init(_ player: Player) {
        self.player = player
        abandonedFilter = AbandonedFilter(player)
    }
    
    func check(_ match: Match) -> Bool {
        match.scores.contains { score in
            score.player == self.player && score.value != match.target
        } && !abandonedFilter.check(match)
    }
}

struct AbandonedFilter: Criteria {
    private let player: Player
    
    init(_ player: Player) {
        self.player = player
    }
    
    func check(_ match: Match) -> Bool {
        match.scores.contains { score in
            score.player == player
        } && match.scores.allSatisfy { score in
            score.value != match.target
        }
    }
}

struct CriteriaManager {
    private var player: Player
    private var activeCriterias: [MatchCriteria] = []
    
    var hasActiveCriterias: Bool {
        activeCriterias.count > 0
    }
    
    init(for player: Player) {
        self.player = player
    }
    
    private var criterias: [Criteria] {
        activeCriterias.map { activeCriteria in
            switch activeCriteria {
            case .won: return WonFilter(player)
            case .lost: return LostFilter(player)
            case .abandoned: return AbandonedFilter(player)
            }
        }
    }
    
    mutating func toggle(_ criteria: MatchCriteria) -> Void {
        if activeCriterias.contains(where: { $0 == criteria }) {
            activeCriterias.removeAll { $0 == criteria }
        } else {
            activeCriterias.append(criteria)
        }
    }
    
    func check(_ matches: [Match]) -> [Match] {
        if criterias.count == 0 {
            return matches
        }
        return matches.filter { match in
            criterias.contains { criteria in
                criteria.check(match)
            }
        }
    }
    
    func status(of criteria: MatchCriteria) -> Bool {
        activeCriterias.contains(where: { $0 ==  criteria })
    }
}

enum MatchCriteria {
    case won, lost, abandoned
}
