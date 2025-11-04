//
//  GameButton.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import SwiftUI

struct GameButton: View {
    
    let buttonType: ButtonType
    var buttonLabel: String = ""
    var bgColor: Color = .green
    var fgColor: Color = .green
    let action: (ButtonType) -> Void
    
    var body: some View {
        let buttonLabel = buttonLabel == "" ? buttonType.description : buttonLabel
        Button(action: {
            action(buttonType)
        }) {
            Text(buttonLabel)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity)
        }
            .buttonStyle(GameButtonStyle(
                size: HelperFuncs.getButtonSize(buttonCount: 4.0),
                fontSize: buttonType.isWide ? 20.0 : 32.0,
                backgroundColor: bgColor == .green ? buttonType.backgroundColor : bgColor,
                foregroundColor: fgColor == .green ? buttonType.foregroundColor : fgColor,
                isWide: buttonType.isWide))
    }
    
}

