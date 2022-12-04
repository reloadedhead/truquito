//
//  ContentView.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import SwiftUI

struct GameView: View {
    @StateObject private var game = GameViewModel()
    
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
                ForEach(game.match.scores, id: \.id) { currentTeamScore in
                    TeamScoreView(score: currentTeamScore) {
                        game.score(for: $0, $1)
                    }
                }.environmentObject(game)
            }
        }
        .onLongPressGesture(minimumDuration: 1) {
            game.reset()
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView().environmentObject(game)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { game.save() }
        }
        .onAppear { game.load() }
    }
}
