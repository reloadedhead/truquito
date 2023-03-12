//
//  SplashView.swift
//  truquito
//
//  Created by Tomás García Gobet on 12.03.23.
//

import SwiftUI

struct SplashView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer(minLength: 100)
            Text("¡Truquito!").font(.system(.title)).bold()
            VStack(alignment: .center, spacing: 25) {
                HStack(alignment: .center) {
                    Image(systemName: "hand.tap.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.purple)
                    VStack(alignment: .leading) {
                        Text("Tocá para sumar")
                            .bold()
                        Text("Tocá una vez para sumar el puntaje de un jugador.")
                            .foregroundColor(.gray)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack(alignment: .center) {
                    Image(systemName: "hand.draw.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.green)
                    VStack(alignment: .leading) {
                        Text("Deslizá para restar")
                            .bold()
                        Text("Deslizá a derecha o izquierda para restar en uno el puntaje de un jugador.")
                            .foregroundColor(.gray)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack(alignment: .center) {
                    Image(systemName: "target")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.orange)
                    VStack(alignment: .leading) {
                        Text("Seleccioná el objetivo")
                            .bold()
                        Text("Podés cambiar entre jugar a 15 o a 30 en cualquier momento.")
                            .foregroundColor(.gray)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Text("Continuar")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding(4)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(42)
            
            Spacer()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
