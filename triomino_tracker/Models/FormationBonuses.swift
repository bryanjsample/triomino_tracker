//
//  FormationBonuses.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/29/25.
//

import Foundation

enum FormationBonuses: CaseIterable, CustomStringConvertible {
    case pizza, bridge, hexagon
    
    var bonus: Int {
        switch self {
        case .pizza:
            return 25
        case .bridge:
            return 40
        case .hexagon:
            return 50
        }
    }
    
    var description: String {
        switch self {
        case .pizza:
            return "pizza"
        case .bridge:
            return "bridge"
        case .hexagon:
            return "hexagon"
        }
    }
}
