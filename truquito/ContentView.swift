//
//  ContentView.swift
//  truquito
//
//  Created by Tomás García Gobet on 22.11.22.
//

import SwiftUI

func random(randomOpacity: Bool = false) -> Color {
    Color(
        red: .random(in: 0...1),
        green: .random(in: 0...1),
        blue: .random(in: 0...1),
        opacity: randomOpacity ? .random(in: 0...1) : 1
    )
}

struct ContentView: View {
    @StateObject private var game = TrucoGame()
    
    @State private var isSettingsPresented = false
    
    @Environment(\.colorScheme) private var colorScheme
    
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
            
            VStack {
                ForEach(game.match.scores, id: \.id) { currentTeamScore in
                    TeamScoreView(
                        teamScore: currentTeamScore,
                        onScore: { game.score(for: $0, $1) },
                        color: color
                    )
                }
            }
        }
        .onLongPressGesture(minimumDuration: 1) {
            game.reset()
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

