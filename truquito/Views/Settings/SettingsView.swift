//
//  SettingsView.swift
//  truquito
//
//  Created by Tomás García Gobet on 27.11.22.
//

import SwiftUI
import UIKit

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("isSharedModeOn") private var isSharedModeOn = false
    @State var isIdleTimerDisabled = UIApplication.shared.isIdleTimerDisabled

    var body: some View {
        NavigationView {
            List {
                Section(
                    header: Text("General"),
                    footer: Text("Al activarse, Truquito va a prevenir que la pantalla de tu dispositivo se apague mientras la aplicación esté abierta.")) {
                        Toggle("Prevenir bloqueo", isOn: $isIdleTimerDisabled).onChange(of: isIdleTimerDisabled) { _, newValue in
                            UIApplication.shared.isIdleTimerDisabled = newValue
                        }
                }
                
                Section(footer: Text("Da vuelta el puntaje superior para compartir el puntaje.")) {
                    Toggle("Modo compartido", isOn: $isSharedModeOn)
                }
                
                PlayerListPreview()
                
                Section() {
                    NavigationLink(destination: AboutView()) {
                        Text("Acerca de")
                    }
                }
            }
            .navigationTitle("Configuración")
            .toolbar() {
                ToolbarItem(placement: .cancellationAction) {
                    if #available(iOS 26.0, *) {
                        Button(role: .close, action: {
                            dismiss()
                        }, label: {
                            Label("Listo", systemImage: "xmark")
                        })
                    } else {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Label("Listo", systemImage: "xmark")
                        })
                    }
                }
            }
        }
    }
}
