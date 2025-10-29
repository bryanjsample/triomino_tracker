//
//  EmptyWellToggleStyle.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/28/25.
//

import SwiftUI

struct EmptyWellToggleStyle: ToggleStyle {
    var size: CGFloat
    var fontSize: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Text(configuration.isOn ? "Empty Well" : "Full Well")
                .font(.system(size: fontSize,  weight: .medium,))
                .multilineTextAlignment(.center)
                .frame(width: size, height: size).frame(maxHeight: HelperFuncs.getButtonSize(buttonCount: 4.0))
                .minimumScaleFactor(0.5)
                .background(configuration.isOn ? .gray : .black)
                .foregroundColor(configuration.isOn ? .black : .white)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
