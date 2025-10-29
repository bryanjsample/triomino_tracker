//
//  HelperFuncs.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/28/25.
//

import SwiftUI

enum HelperFuncs {
    
    static func getButtonSize(buttonCount:CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let spacingCount = buttonCount + 1
        return (screenWidth - (spacingCount * Constants.padding)) / buttonCount
    }
    
}
