//
//  Scoreboard.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/28/25.
//

import SwiftUI

struct Scoreboard: View {
    
    @Bindable var gameData: GameData
    
    var body: some View {
        scoreboardNames
        scoreboardScores
    }
    
    // WORKING ON FORMATTING SCOREBOARD TO DISPLAY WHOSE TURN IT IS
    // THINKING WE NEED TO CREATE A FUNCTION THAT RETURNS A BOOLEAN WHETHER PLAYER.NAME MATCHES INDEX OF CURRENT TURN

    var scoreboardNames: some View {
        HStack(spacing:Constants.padding){
            ForEach(gameData.players, id:\.self) { player in
                Text(player.name)
                    .font(.system(size: 20.0, weight: .medium))
                    .frame(
                        width:HelperFuncs.getButtonSize(buttonCount: CGFloat(gameData.players.count)),
                        height:(HelperFuncs.getButtonSize(buttonCount: 4.0) / 2)
                    )
                    .background(player.isCurrentPlayer(gameData: gameData) ? .gray : .black)
                    .foregroundColor(player.isCurrentPlayer(gameData: gameData) ? .black : .white)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.padding))
            }
        }
    }
    
    var scoreboardScores: some View {
        HStack(spacing:Constants.padding){
            ForEach(gameData.players, id:\.self) { player in
                Text(String(player.score))
                    .font(.system(size: 20.0, weight: .medium))
                    .frame(
                        width:HelperFuncs.getButtonSize(buttonCount: CGFloat(gameData.players.count)),
                    )
            }
        }
    }
    
    private func getScoreWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let numPlayers = gameData.players.count
        let numGaps = numPlayers + 1
        
        return (screenWidth - (CGFloat(numGaps) * Constants.padding)) / CGFloat(numPlayers)
    }
}
