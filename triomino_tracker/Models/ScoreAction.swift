//
//  ScoreAction.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import Foundation

enum ScoreAction: CaseIterable, CustomStringConvertible {
    case wellEmpty, draw, pizza, bridge, hexagon, edit, undo, new
    
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
        case .edit:
            return "Edit Scores"
        case .undo:
            return "Undo"
        case .new:
            return "New Round"
        }
    }
}
