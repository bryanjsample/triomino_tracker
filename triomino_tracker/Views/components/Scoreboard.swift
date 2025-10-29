//
//  Scoreboard.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/28/25.
//

import SwiftUI

extension InGameView {
    struct Scoreboard: View {
        
        @Bindable var gameData: GameData
        
        var body: some View {
            scoreBoardNames
            scoreBoardScores
        }
        
        // WORKING ON FORMATTING SCOREBOARD TO DISPLAY WHOSE TURN IT IS
        // THINKING WE NEED TO CREATE A FUNCTION THAT RETURNS A BOOLEAN WHETHER PLAYER.NAME MATCHES INDEX OF CURRENT TURN
    
        private var scoreBoardNames: some View {
            HStack(spacing:Constants.padding){
                ForEach(gameData.players, id:\.self) { player in
                    Text(player.name)
                        .frame(
                            width:HelperFuncs.getButtonSize(buttonCount: CGFloat(gameData.players.count)),
                            height:(HelperFuncs.getButtonSize(buttonCount: 4) / 2)
                        )
                        .background(.black)
                        .foregroundColor(.white)
                }
            }
        }
        
        private var scoreBoardScores: some View {
            HStack(spacing:Constants.padding){
                ForEach(gameData.players, id:\.self) { player in
                    Text(String(player.score))
                        .frame(width:getScoreWidth(), height: 20.0)
                }
            }
        }
        
        func getScoreWidth() -> CGFloat {
            let screenWidth = UIScreen.main.bounds.width
            let numPlayers = gameData.players.count
            let numGaps = numPlayers + 1
            
            return (screenWidth - (CGFloat(numGaps) * Constants.padding)) / CGFloat(numPlayers)
        }
    }
}
