//
//  ButtonType.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import Foundation
import SwiftUI

enum ButtonType: Hashable, CustomStringConvertible {
    case digit(_ digit:Digit)
    case gameAction(_ action:GameAction)
    
    var description: String {
        switch self {
        case .digit(let digit):
            return digit.description
        case .gameAction(let gameAction):
            return gameAction.description
        }
    }
    
    var pointValue: Int {
        switch self {
        case.digit:
            return 0
        case .gameAction(let domino):
            return domino.pointValue
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .digit:
            return Color(.lightGray)
        case .gameAction:
            return .black
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .digit:
            return .black
        case.gameAction:
            return .white
        }
    }
    
    var isWide: Bool {
        switch self {
        case .digit:
            return false
        case .gameAction:
            return true
        }
    }
}
