//
//  ButtonGrid.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/28/25.
//

import SwiftUI

extension InRoundView {
    
    struct ButtonGrid: View {
        
        @Bindable var gameData:GameData
        @Binding var path : NavigationPath
        
        var body: some View {
            buttonGrid
        }
        
        private var buttonTypes: [[ButtonType]] {
            [[.gameAction(.wellEmpty), .gameAction(.draw)],
             [.gameAction(.pizza), .gameAction(.bridge), .gameAction(.hexagon)],
             [.digit(.zero), .digit(.one), .digit(.two), .digit(.three)],
             [.digit(.four), .digit(.five), .digit(.six), .digit(.seven)],
             [.digit(.eight), .digit(.nine), .digit(.ten), .digit(.eleven)],
             [.digit(.twelve), .digit(.thirteen), .digit(.fourteen), .digit(.fifteen)],
             [.gameAction(.undo), .gameAction(.endRound)]]
        }
        
        private var buttonGrid: some View {
            VStack(spacing: Constants.padding) {
                ForEach(buttonTypes, id: \.self) { row in
                    HStack(spacing: Constants.padding) {
                        ForEach(row, id: \.self) { buttonType in
                            ButtonGridButton(gameData: gameData, path: $path, buttonType: buttonType)
                        }
                    }
                }
            }
        }
    }
}

