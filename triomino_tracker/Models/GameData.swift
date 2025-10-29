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
    var formationBonus: Int
    var drawPenalties: Int
    var wellIsEmpty: Bool
    
    init() {
        self.id = UUID()
        self.players = []
        self.rounds = []
        self.currentRound = 0
        self.currentTurn = 0
        self.formationBonus = 0
        self.drawPenalties = 0
        self.wellIsEmpty = false
    }
    
    func addPlayer(_ player: Player) {
        self.players.append(player)
    }
    
    func nextRound(roundData round: RoundData) {
        if self.rounds.count != 0 {
            self.currentRound += 0
        }
        self.rounds.append(round)
    }
    
    func startGame() {
        @State var roundData = RoundData(gameID:self.id)
        self.nextRound(roundData: roundData)
    }
    
    func nextTurn() {
        self.formationBonus = 0
        self.drawPenalties = 0
        let numPlayers = self.players.count
        if self.currentTurn == numPlayers - 1 {
            self.currentTurn = 0
        } else {
            self.currentTurn += 1
        }
    }

}
