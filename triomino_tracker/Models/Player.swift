//
//  Player.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import Foundation
import Observation

@Observable
class Player: Hashable {
    
    let id: UUID
    var name: String = ""
    var score: Int = 0
    
    init (name:String, score:Int) {
        self.id = UUID()
        self.name = name
        self.score = score
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
    
    func addPlayerScore(score: Int) {
        self.score += score
    }
}
