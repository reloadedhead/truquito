//
//  ProgressBar.swift
//  truquito
//
//  Created by Tomás García Gobet on 14.03.23.
//

import SwiftUI

struct ProgressBar: View {
    @ObservedObject var currentMatch = MatchManager.shared.currentMatch
    
    var color: Color
    var value: Int
    
    var body: some View {
        let percentage = Double(value) / Double(currentMatch.target)
        
        return GeometryReader { geometry in
            Rectangle()
                .foregroundColor(color)
                .shadow(color: color, radius: 10)
                .frame(width: geometry.size.width * CGFloat(percentage) )
                .animation(.linear, value: percentage)
                .blendMode(.multiply)
        }
        .frame(height: 8)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.red
            ProgressBar(color: .red, value: 15)
        }
    }
}
