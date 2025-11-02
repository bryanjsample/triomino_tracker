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
    //    @State private var route: Route? = nil
    @Binding var path: NavigationPath
    
    
    
    /*
     
     Struggling to get this working. I am quite certain that I just need to keep track of route state and use switch case block inside of navigationDestination block to determine what view to move to
     
     Im grumpy and going to take a break
     
     */
    
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
