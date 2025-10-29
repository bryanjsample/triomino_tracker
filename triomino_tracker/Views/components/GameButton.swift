//
//  GameButton.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import SwiftUI

extension InGameView {
    
    struct GameButton: View {
        
        let buttonType: ButtonType
        let action: (ButtonType) -> Void
        
        var body: some View {
            Button(buttonType.description) {
                action(buttonType)
            }
                .buttonStyle(GameButtonStyle(
                    size: HelperFuncs.getButtonSize(buttonCount: 4.0),
                    fontSize: buttonType.isWide ? 20.0 : 32.0,
                    backgroundColor: buttonType.backgroundColor,
                    foregroundColor: buttonType.foregroundColor,
                    isWide: buttonType.isWide))
        }
    }
}
