//
//  NameEntryStyle.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/29/25.
//

import SwiftUI

struct NameEntryStyle: TextFieldStyle {
    var backgroundColor: Color = .gray.opacity(0.1)
    var cornerRadius: CGFloat = Constants.padding
    var padding: CGFloat = Constants.padding
    var borderColor: Color = .gray.opacity(0.1)
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(padding)
            .background(backgroundColor)
            .frame(width: HelperFuncs.getButtonSize(buttonCount: 1.0))
            .font(.title)
            .fontWeight(.bold)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .autocorrectionDisabled()
    }
}
