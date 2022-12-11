//
//  LogView.swift
//  truquito
//
//  Created by Tomás García Gobet on 11.12.22.
//

import SwiftUI

struct LogView: View {
    var matches: [Match]
    
    var onDelete: (_ :IndexSet) -> Void
    
    var body: some View {
        List {
            ForEach(matches) { match in
                LogRow(log: match)
            }
            .onDelete(perform: { onDelete($0) })
        }
        .navigationTitle("Historial")
    }
}
