//
//  CreatePlayer.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import SwiftUI

struct CreatePlayer: View {
    @State private var name: String = ""
    @Environment(\.presentationMode) var presentationMode

    let playerManager = PlayerManager()
    
    func handleSave() {
        playerManager.add(name: name)
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            List {
                Section("Nombre") {
                    TextField("Nombre", text: $name)
                }
            }
        
            
        }
        .navigationTitle(name.isEmpty ? "Nuevo jugador" : name).toolbar {
            Button("Agregar") { handleSave() }
                .disabled(name.isEmpty)
        }
    }
}
