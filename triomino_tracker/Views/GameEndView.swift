//
//  GameEndView.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 11/3/25.
//

import SwiftUI

struct GameEndView: View {
    
    @Bindable var gameData: GameData
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            Scoreboard(gameData: gameData)
            Spacer()
            winnerText
            Spacer()
            newGameButton
        }.navigationTitle("")
            .toolbar(.hidden)
    }
    
    private var winnerText: some View {
        Text("\(getWinnerName()) won! 🎉")
            .font(.system(size: 32.0, weight: .bold))
    }
    
    private var newGameButton: some View {
        GameButton(buttonType: .gameAction(.endGame), bgColor: .black, fgColor: .white) { pressedButton in
            
            gameData.resetGame()
            while path.count > 0 {
                path.removeLast()
            }
            
        }.padding(.horizontal, Constants.padding)
            .fontWeight(.bold)
    }
    
    private func getWinnerName() -> String {
        if gameData.winner == nil {
            return "Nobody"
        } else {
            return gameData.winner!.name
        }
    }
    
}

struct GameEndView_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var previewData = GameData()
        @State var path = NavigationPath()
        
        GameEndView(gameData: previewData, path: $path).onAppear {
            previewData.addPlayer(Player(name: "Richie", score: 0))
            previewData.addPlayer(Player(name: "Bryan", score: 0))
            previewData.addPlayer(Player(name: "Kelissa", score: 0))
            
            previewData.winner = previewData.players[1]
        }
    }
}
