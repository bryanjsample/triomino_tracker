//
//  GameData.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/28/25.
//

import SwiftUI

@Observable
class GameData {
    let id: UUID
    var players: [Player]
    var rounds: [RoundData]
    var currentRound: Int
    var currentTurn: Int
    var currentFormationBonus: Int
    var drawPenalties: Int
    var wellIsEmpty: Bool
    var winner : Player?
    
    
    init() {
        self.id = UUID()
        self.players = []
        self.rounds = []
        self.currentRound = 0
        self.currentTurn = 0
        self.currentFormationBonus = 0
        self.drawPenalties = 0
        self.wellIsEmpty = false
        self.winner = nil
        self.nextRound()
    }
    
    func addPlayer(_ player: Player) {
        self.players.append(player)
    }
    
    func nextRound() {
        @State var roundData = RoundData(gameID:self.id)
        
        self.currentTurn = 0
        self.currentFormationBonus = 0
        self.drawPenalties = 0
        self.wellIsEmpty = false
        
        if self.rounds.count != 0 {
            self.currentRound += 1
        }
        
        self.rounds.append(roundData)
        self.rounds[self.currentRound].startingPoints = 0
        self.rounds[self.currentRound].startingTurn = 0
        
    }
    
    func nextTurn() {
        self.currentFormationBonus = 0
        self.drawPenalties = 0
        let numPlayers = self.players.count
        if self.currentTurn == numPlayers - 1 {
            self.currentTurn = 0
        } else {
            self.currentTurn += 1
        }
    }
    
    func checkForWinner() -> Player? {
        var winners: [Int:Player] = [:]
        for player in self.players {
            if player.score >= 400 {
                winners[player.score] = player
            }
        }
        if winners.count == 1 {
            return Array(winners.values)[0]
        } else {
            var highestScore = 0
            var winner: Player?
            for (score, player) in winners {
                if score > highestScore {
                    highestScore = score
                    winner = player
                } else if score == highestScore {
                    winner = nil
                }
            }
            return winner
        }
    }
    
    func resetGame() {
        for player in self.players {
            player.score = 0
        }
        self.players = []
        self.rounds = []
        self.currentRound = 0
        self.currentTurn = 0
        self.currentFormationBonus = 0
        self.drawPenalties = 0
        self.wellIsEmpty = false
        self.winner = nil
        self.nextRound()
    }
}
