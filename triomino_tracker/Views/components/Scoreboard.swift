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
    
    var scoreboardNames: some View {
        HStack(spacing:Constants.padding){
            ForEach(gameData.players, id:\.self) { player in
                Text(player.name)
                    .font(.system(size: 20.0, weight: .medium))
                    .frame(
                        width:HelperFuncs.getButtonSize(buttonCount: CGFloat(gameData.players.count)),
                        height:(HelperFuncs.getButtonSize(buttonCount: 4.0) / 2)
                    )
                    .background(player.isCurrentPlayer(gameData: gameData) ? Color(.lightGray) : .black)
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
                    .overlay(
                        Group {
                            if let points = player.lastPointsAdded, player.showBonus {
                                Text(getScoreAddedString(points))
                                    .font(.system(size: 12.5, weight: .bold))
                                    .foregroundColor(points > 0 ? .green : .red)
                                    .offset(x: HelperFuncs.getButtonSize(buttonCount: CGFloat(gameData.players.count)) / 3.0)
                                    .transition(.opacity.combined(with: .move(edge: .top)))
                            }
                        }
                    )
                    .animation(.easeOut(duration: 0.4), value: player.showBonus)
                }
            }
        }
    
    private func getScoreWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let numPlayers = gameData.players.count
        let numGaps = numPlayers + 1
        
        return (screenWidth - (CGFloat(numGaps) * Constants.padding)) / CGFloat(numPlayers)
    }
    
    private func getScoreAddedString(_ points: Int) -> String {
        if points > 0 {
            return "+\(points)"
        } else {
            return "\(points)"
        }
    }
}
