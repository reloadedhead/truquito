//
//  ContentView.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import SwiftUI

struct GameView: View {
    @StateObject private var gameStore = GameStore()
    @State private var isSettingsPresented = false
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.scenePhase) private var scenePhase
    
    let color = random()
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                Spacer()
                Button(action: { isSettingsPresented.toggle() }) {
                    Image(systemName: "gear.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .zIndex(1)
                }
            }
            .padding()
            .zIndex(10)
            .tint(colorScheme == .dark ? .white : .black)
            .opacity(0.5)
            .onTapGesture { isSettingsPresented.toggle() }
            
            VStack(spacing: 0) {
                ForEach(gameStore.match.scores, id: \.id) { currentTeamScore in
                    TeamScoreView(score: currentTeamScore) {
                        gameStore.score(for: $0, $1)
                    }
                }.environmentObject(gameStore)
            }
        }
        .onLongPressGesture(minimumDuration: 1) {
            gameStore.reset()
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView().environmentObject(gameStore)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                GameStore.save(match: gameStore.match) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
            }
        }
        .onAppear {
            GameStore.load { result in
                switch result {
                case .failure(let error):
                    fatalError(error.localizedDescription)
                case .success(let match):
                    gameStore.match = match
                }
            }
        }
    }
}
