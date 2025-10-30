//
//  NewRoundButton.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/29/25.
//

import SwiftUI

extension InRoundView {
    
    struct NewRoundButton: View {
        @Bindable var gameData: GameData
        
        var body: some View {
            Text("New Round")
                .font(.system(size: 20.0, weight: .medium))
                .frame(
                    width: HelperFuncs.getButtonSize(buttonCount: 3.0),
                    height: HelperFuncs.getButtonSize(buttonCount: 4.0)
                )
                .background(.black)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: Constants.padding))
        }
    }
}
