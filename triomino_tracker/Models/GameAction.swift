//
//  GameAction.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import Foundation

enum GameAction: Hashable, CaseIterable, CustomStringConvertible {
    case wellEmpty, draw, pizza, bridge, hexagon, undo, name, domino0, domino1, domino2, domino3, domino4, domino5, startGame, endGame, startRound, endRound
    
    var pointValue: Int {
        switch self {
        case .domino0:
            return 40
        case .domino1:
            return 13
        case .domino2:
            return 16
        case .domino3:
            return 19
        case .domino4:
            return 22
        case .domino5:
            return 25
        default:
            return 0
            
        }
    }
    
    var description: String {
        switch self {
        case .wellEmpty:
            return "Empty Well"
        case .draw:
            return "Draw Triomino"
        case .pizza:
            return "Pizza Slice\n+25"
        case .bridge:
            return "Bridge\n+40"
        case .hexagon:
            return "Hexagon\n+50"
        case .undo:
            return "Undo"
        case .name:
            return "Name"
        case .domino0:
            return "Triple Zeroes"
        case .domino1:
            return "Triple Ones"
        case .domino2:
            return "Triple Twos"
        case .domino3:
            return "Triple Threes"
        case .domino4:
            return "Triple Fours"
        case .domino5:
            return "Triple Fives"
        case .startRound:
            return "Start New Round"
        case .endRound:
            return "End Round"
        case .startGame:
            return "Start Game"
        case .endGame:
            return "End Game"
        }
    }
}
