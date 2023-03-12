//
//  ExternalLinkView.swift
//  truquito
//
//  Created by Tomás García Gobet on 12.03.23.
//

import SwiftUI

struct ExternalLinkView: View {
    var url: String
    var symbolName: String
    var label: String
    var color: Color
    
    var body: some View {
        Link(destination: URL(string: url)!) {
            HStack {
                Image(systemName: symbolName)
                    .frame(width: 28, height: 28)
                    .background(color)
                    .cornerRadius(5)
                    .foregroundColor(Color.white)
                Text(label)
                    .foregroundColor(.black)
                Spacer()
         
                Image(systemName: "arrow.up.forward.app")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ExternalLinkView_Previews: PreviewProvider {
    static var previews: some View {
        ExternalLinkView(url: "test", symbolName: "hammer.circle", label: "Proyecto en GitHub", color: .purple)
    }
}
