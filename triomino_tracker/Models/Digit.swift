//
//  Digit.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import Foundation

enum Digit: Int, CaseIterable, CustomStringConvertible {
    case zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen
    
    var description: String {
        "\(rawValue)"
    }
    
}
