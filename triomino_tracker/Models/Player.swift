//
//  Player.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import SwiftUI
import Observation

@Observable
class Player: Hashable {
    
    let id: UUID
    var name: String = ""
    var score: Int = 0
    var showBonus: Bool
    var lastPointsAdded: Int?
    
    init (name:String, score:Int) {
        self.id = UUID()
        self.name = name
        self.score = score
        self.showBonus = false
        self.lastPointsAdded = nil
    }
    
    static func == (lhs:Player, rhs:Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func setPlayerName(name: String) {
        self.name = name
    }
    
    func addPlayerScore(gameData: GameData, score: Int) {
        self.score += score
        self.lastPointsAdded = score
        withAnimation {
            self.showBonus = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                self.showBonus = false
            }
        }
    }
    
    func isCurrentPlayer(gameData: GameData) -> Bool {
        gameData.players[gameData.currentTurn].id == self.id
    }
}
