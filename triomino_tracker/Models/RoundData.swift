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
    var moves: [Move]
    
    init(gameID:UUID) {
        self.roundID = UUID()
        self.gameID = gameID
        self.moves = []
    }
}
