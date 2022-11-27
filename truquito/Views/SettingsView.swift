//
//  SettingsView.swift
//  truquito
//
//  Created by Tomás García Gobet on 27.11.22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Button("Press to dismiss") {
                dismiss()
            }
            .font(.title)
            .padding()
            .background(.black)
        }.navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
