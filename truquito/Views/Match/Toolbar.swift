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
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: { isSettingsPresented.toggle() }) {
                Image(systemName: "gear")
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

struct Toolbar_Previews: PreviewProvider {
    static var previews: some View {
        Toolbar()
    }
}
