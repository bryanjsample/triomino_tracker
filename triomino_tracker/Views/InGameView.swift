//
//  InGameView.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import SwiftUI
import Observation

// add functionality to all buttons
// finish styling labels to make it look better


struct InGameView: View {
    
    @Bindable var gameData: GameData
    @State var wellIsEmpty: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Scoreboard(gameData: gameData)
                ButtonGrid(gameData: gameData)
                    .padding(Constants.padding)
            }
        }.navigationTitle("")
            .toolbar(.hidden)
    }
}

struct InGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var previewData = GameData()
        
        InGameView(gameData: previewData).onAppear {
            previewData.startGame()
            previewData.addPlayer(Player(name: "Richie", score: 0))
            previewData.addPlayer(Player(name: "Bryan", score: 0))
            previewData.addPlayer(Player(name: "Kelissa", score: 0))
        }
    }
}

