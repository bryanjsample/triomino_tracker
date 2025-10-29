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
    case scoreAction(_ action:ScoreAction)
    
    var description: String {
        switch self {
        case .digit(let digit):
            return digit.description
        case .scoreAction(let scoreAction):
            return scoreAction.description
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .digit:
            return Color(.lightGray)
        case .scoreAction:
            return .black
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .digit:
            return .black
        case.scoreAction:
            return .white
        }
    }
    
    var isWide: Bool {
        switch self {
        case .digit:
            return false
        case .scoreAction:
            return true
        }
    }
}
