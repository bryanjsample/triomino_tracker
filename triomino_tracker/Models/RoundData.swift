//
//  Round.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/28/25.
//

import SwiftUI

@Observable
class RoundData {
    let roundID: UUID
    let gameID: UUID
    var startingTurn : Int
    var startingPoints: Int
    var moves: [Move]
    var roundWinner: Player?
    var winBonus: Int
    
    init(gameID:UUID) {
        self.roundID = UUID()
        self.gameID = gameID
        self.startingTurn = 0
        self.startingPoints = 0
        self.moves = []
        self.roundWinner = nil
        self.winBonus = 25
    }
    
    func addNewMove(move: Move) {
        self.moves.append(move)
    }
    
    func undoLastMove(gameData: GameData) {

        if let lastMove = self.moves.popLast() {
            if lastMove.scoreAdded != -5 {
                gameData.currentFormationBonus = 0
                gameData.drawPenalties = 0
                let numPlayers = gameData.players.count
                if gameData.currentTurn == 0 {
                    gameData.currentTurn = numPlayers - 1
                } else {
                    gameData.currentTurn -= 1
                }
            }
            lastMove.player.addPlayerScore(gameData: gameData, score: lastMove.scoreAdded * -1)
        } else {
            return
        }
    }
    
    func setStartingPoints(_ points:Int) {
        self.startingPoints = points
    }
}
