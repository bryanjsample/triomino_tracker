//
//  InGameView.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import SwiftUI

struct InRoundView: View {
    
    @Bindable var gameData: GameData
    @State var wellIsEmpty: Bool = false
    @Binding var path: NavigationPath
    

    
    var body: some View {
        VStack {
            Scoreboard(gameData: gameData)
            ButtonGrid(gameData: gameData, path: $path)
                .padding(Constants.padding)
        }.navigationTitle("")
            .toolbar(.hidden)
    }
}
    
    
    
struct InRoundView_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var previewData = GameData()
        @State var path = NavigationPath()
        
        InRoundView(gameData: previewData, path: $path).onAppear {
            previewData.addPlayer(Player(name: "Richie", score: 0))
            previewData.addPlayer(Player(name: "Bryan", score: 0))
            previewData.addPlayer(Player(name: "Kelissa", score: 0))
        }
    }
}
