//
//  LogList.swift
//  truquito
//
//  Created by Tomás García Gobet on 04.12.22.
//

import SwiftUI

struct LogList: View {
    var matches: [Match]
    
    var body: some View {
        Section("Historial") {
            if (self.matches.count > 4) {
                ForEach(matches.suffix(4)) { match in
                    LogRow(log: match)
                }
                NavigationLink("Ver más...") {
                    LogView(matches: matches)
                }
            } else {
                ForEach(matches) { match in
                    LogRow(log: match)
                }
            }
        }
    }
}
