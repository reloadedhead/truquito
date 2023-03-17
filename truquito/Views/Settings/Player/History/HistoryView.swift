//
//  HistoryView.swift
//  truquito
//
//  Created by Tomás García Gobet on 15.03.23.
//

import SwiftUI

struct HistoryView: View {
    var matches: [Match]
    var player: Player
    @State var criteriaManager: CriteriaManager
    
    init(matches: [Match], player: Player) {
        self.matches = matches
        self.player = player
        self.criteriaManager = CriteriaManager(for: player)
    }
    
    
    var body: some View {
        VStack {
            List {
                ForEach(criteriaManager.check(matches)) { match in
                    HistoryRow(match: match, player: player)
                }
            }
        }
        .navigationTitle("Historial")
        .toolbar {
            Menu(content: {
                Section("Filtrar") {
                    FilterButton(name: "Partidos ganados", symbolName: "medal", isActive: criteriaManager.status(of: .won)) {
                        criteriaManager.toggle(.won)
                    }

                    FilterButton(name: "Partidos perdidos", symbolName: "hand.thumbsdown", isActive: criteriaManager.status(of: .lost)) {
                        criteriaManager.toggle(.lost)
                    }

                    FilterButton(name: "Partidos abandonados", symbolName: "door.left.hand.open", isActive: criteriaManager.status(of: .abandoned)) {
                        criteriaManager.toggle(.abandoned)
                    }
                }
            }) {
                Image(systemName: criteriaManager.hasActiveCriterias ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(matches: MatchManager.shared.matches, player: PlayerManager.shared.players[0])
    }
}
