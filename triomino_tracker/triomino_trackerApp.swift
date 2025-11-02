//
//  triomino_trackerApp.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import SwiftUI

@main
struct triomino_trackerApp: App {
    
    var body: some Scene {
        WindowGroup {
            StartGameView()
                .preferredColorScheme(.light)
        }
    }
}
