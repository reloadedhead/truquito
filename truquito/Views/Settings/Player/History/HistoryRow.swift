//
//  HistoryRow.swift
//  truquito
//
//  Created by Tomás García Gobet on 15.03.23.
//

import SwiftUI
import SwiftData

struct HistoryRow: View {
    var match: Match
    var player: Player
    
    private func didWin() -> Bool {
        if let winningScore = match.scores.first(where: { $0.player == player }) {
            return winningScore.value == match.target
        }
        
        return false
    }
    
    private var adversary: Player? {
        match.scores.first { $0.player != player }?.player
    }
    
    private var scores: [Score] {
        match.scores.sorted { $0.value > $1.value }
    }

    var body: some View {
        HStack {
            Text("\(scores[0].value) - \(scores[1].value) contra \(adversary?.name ?? "jugador eliminado")")
            Spacer()
            if didWin() {
                Image(systemName: "medal").foregroundColor(.yellow)
            }
        }
    }
}

struct HistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.mainContext
        let match = try! context.fetch(FetchDescriptor<Match>(sortBy: [SortDescriptor(\.beginDate, order: .reverse)])).first!
        let player = match.scores[0].player!

        return List {
            HistoryRow(match: match, player: player)
        }
        .modelContainer(PersistenceController.preview)
    }
}
