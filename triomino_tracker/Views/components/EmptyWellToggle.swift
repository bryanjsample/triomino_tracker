//
//  EmptyWellToggle.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/28/25.
//

import SwiftUI


extension InRoundView {
    
    struct EmptyWellToggle: View {
        
        @Bindable var gameData: GameData
        
        var body: some View {
            Toggle(isOn: $gameData.wellIsEmpty) { Text(gameData.wellIsEmpty ? "Empty Well" : "Full Well") }
                .toggleStyle(EmptyWellToggleStyle(size: HelperFuncs.getButtonSize(buttonCount: 3), fontSize: 20.0))
        }
    }
}
