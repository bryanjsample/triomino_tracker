//
//  StartGameButtonStyle.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import SwiftUI

struct StartGameButtonStyle: ButtonStyle {
    var width: CGFloat
    var backgroundColor: Color
    var foregroundColor:Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .frame(width: width, height: 50.0)
            .minimumScaleFactor(0.5)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .overlay {
                if configuration.isPressed {
                    Color(white: 1.0, opacity: 0.2)
                }
            }
            .clipShape(Capsule())
    }
}
