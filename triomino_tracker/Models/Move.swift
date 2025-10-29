//
//  Move.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/28/25.
//

import SwiftUI

@Observable
class Move {
    let id: UUID
    let player: Player
    let scoreAdded: Int
    
    init (player:Player, scoreAdded: Int) {
        self.id = UUID()
        self.player = player
        self.scoreAdded = scoreAdded
    }
}
