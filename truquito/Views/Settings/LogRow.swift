//
//  LogRow.swift
//  truquito
//
//  Created by Tomás García Gobet on 04.12.22.
//

import SwiftUI

struct LogRow: View {
    var log: Match
    
    var body: some View {
        HStack {
            Image(systemName: "calendar")
                .frame(width: 10)
            Text(getLogLabel(for: log))
            Spacer()
        }
    }
}

func getLogLabel(for log: Match) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    
    if (log.endDate == nil) {
        return "En curso"
    }
    if let winnerId = getWinnerId(for: log) {
        return String("\(dateFormatter.string(from: log.endDate!)) – ganó \(log.teams.first(where: { $0.id == winnerId })!.name)")
    } else {
        return "Abandonado"
    }
}

func getWinnerId(for match: Match) -> UUID? {
    print(match.scores)
    if let winner = match.scores.first(where: {
        $0.value == 30
    }) {
        return winner.teamId
    } else {
        return nil
    }
}


struct LogRow_Previews: PreviewProvider {
    static var previews: some View {
        let teamA = Team(name: "Team A")
        var match = Match(teams: [teamA, Team(name: "Team B")])
        match.score(for: teamA.id, 30)
        match.endDate = Date.now
        
        return LogRow(log: match)
    }
}
