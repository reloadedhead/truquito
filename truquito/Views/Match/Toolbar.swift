//
//  Toolbar.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import SwiftUI

struct Toolbar: View {
    @State private var isSettingsPresented = false
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject private var currentMatch = MatchManager.shared.currentMatch
    
    private let matchManager = MatchManager.shared
    var target: Int {
        currentMatch.target
    }
    
    var body: some View {
        HStack {
            Menu(content: {
                Section("Seleccioná un objetivo") {
                    ForEach(Targets.allCases, id: \.self) { option in
                            Button(action: { matchManager.change(target: option.rawValue) }) { Text("Jugar a \(option.rawValue)")
                        }
                    }
                }
            }) {
                HStack {
                    Image(systemName: "target")
                    Text("\(target)")
                        .font(.title3)
                        .padding(2)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.clear)
                        .background(
                            BlurView(style: .systemThinMaterial)
                                .cornerRadius(14)
                        )
                )
                
            }
            .tint(colorScheme == .dark ? .white : .black)
            .onTapGesture {}
            
            Spacer()
            Button(action: { matchManager.reset() }) {
                Image(systemName: "arrow.counterclockwise.circle")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .zIndex(1)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(Color.clear)
                            .background(BlurView(style: .systemThinMaterial).cornerRadius(100))
                    )
            }
            Button(action: { isSettingsPresented.toggle() }) {
                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .zIndex(1)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(Color.clear)
                            .background(BlurView(style: .systemThinMaterial).cornerRadius(100))
                    )
            }
        }
        .padding()
        .zIndex(10)
        .tint(colorScheme == .dark ? .white : .black)
        .opacity(0.5)
        .onTapGesture { isSettingsPresented.toggle() }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView()
        }

    }}
