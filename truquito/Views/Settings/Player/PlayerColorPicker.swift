//
//  PlayerColorPicker.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.08.26.
//

import SwiftUI

struct PlayerColorPicker: View {
    static let palette: [(name: String, color: Color)] = [
        ("Rojo", .red),
        ("Naranja", .orange),
        ("Amarillo", .yellow),
        ("Verde", .green),
        ("Menta", .mint),
        ("Azul", .blue),
        ("Violeta", .purple),
        ("Rosa", .pink)
    ]

    @Binding var selection: Color

    var body: some View {
        Picker("Color", selection: $selection) {
            ForEach(Self.palette, id: \.color) { item in
                Text(item.name).tag(item.color)
            }
        }
    }
}

struct PlayerColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        PlayerColorPicker(selection: .constant(.blue))
            .padding()
    }
}
