//
//  FilterButton.swift
//  truquito
//
//  Created by Tomás García Gobet on 15.03.23.
//

import SwiftUI

struct FilterButton: View {
    var name: String
    var symbolName: String
    var isActive = false
    
    var onTap: () -> Void
    
    var body: some View {
        Button(action: { onTap() }) {
            if (isActive) {
                Image(systemName: "checkmark")
            }
            Label(name, systemImage: symbolName)
        }
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        Menu(content: {
            FilterButton(name: "Todos", symbolName: "list.bullet", onTap: {}).previewDisplayName("Non-selected filter")
            FilterButton(name: "Todos", symbolName: "list.bullet", isActive: true, onTap: {}).previewDisplayName("Selected filter")
        }) {
            Image(systemName: "line.3.horizontal.decrease.circle")
        }
        FilterButton(name: "Todos", symbolName: "list.bullet", onTap: {}).previewDisplayName("Non-selected filter")
        FilterButton(name: "Todos", symbolName: "list.bullet", isActive: true, onTap: {}).previewDisplayName("Selected filter")
    }
}
