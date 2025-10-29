//
//  triomino_trackerApp.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import SwiftUI

@main
struct triomino_trackerApp: App {

    @State var gameData = GameData()
    
    var body: some Scene {
        WindowGroup {
            NewGameView(gameData: gameData)
        }
    }
}
