//
//  GameButtonStyle.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import SwiftUI

struct GameButtonStyle: ButtonStyle {
    var size: CGFloat
    var fontSize: CGFloat
    var backgroundColor: Color
    var foregroundColor:Color
    var isWide: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: fontSize,  weight: .medium,))
            .multilineTextAlignment(.center)
            .frame(width: size, height: size)
            .frame(maxWidth: isWide ? .infinity : size)
            .minimumScaleFactor(0.5)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .overlay {
                if configuration.isPressed {
                    Color(white: 1.0, opacity: 0.2)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: Constants.padding))
    }
}

