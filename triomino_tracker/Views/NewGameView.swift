//
//  NewGameView.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import SwiftUI
import Observation


struct NewGameView: View {
    
    @Bindable var gameData: GameData
    
    @State private var playerOneName: String = ""
    @State private var playerTwoName: String = ""
    @State private var playerThreeName: String = ""
    @State private var playerFourName: String = ""
    
    @State var playerOne: Player = Player(name: "", score: 0)
    @State var playerTwo: Player = Player(name: "", score: 0)
    @State var playerThree: Player = Player(name: "", score: 0)
    @State var playerFour: Player = Player(name: "", score: 0)
    
    var body: some View {
        
        NavigationView {
            VStack(spacing:Constants.padding) {
                Spacer()
                pageTitle
                playerNameInputFields
                NavigationLink(destination: InGameView(gameData: gameData).onAppear {
                    
                    if playerOneName != "" {
                        playerOne.setPlayerName(name: playerOneName)
                        gameData.players.append(playerOne)
                    }; if playerTwoName != "" {
                        playerTwo.setPlayerName(name: playerTwoName)
                        gameData.players.append(playerTwo)
                    }; if playerThreeName != "" {
                        playerThree.setPlayerName(name: playerThreeName)
                        gameData.players.append(playerThree)
                    }; if playerFourName != "" {
                        playerFour.setPlayerName(name: playerFourName)
                        gameData.players.append(playerFour)
                    }
                    gameData.startGame()
                } ) {
                    startGameButton
                }
                Spacer()
            }
        }
    }
}

extension NewGameView {
    
    private var playerNameInputFields: some View {
        VStack(spacing:Constants.padding) {
            TextField("Player One", text: $playerOneName)
            TextField("Player Two", text: $playerTwoName)
            TextField("Player Three", text: $playerThreeName)
            TextField("Player Four", text: $playerFourName)
        }
            .padding(Constants.padding)
            .textFieldStyle(.roundedBorder)
            .font(.system(size: 25))
            .disableAutocorrection(true)
    }
    
    private var pageTitle: Text {
        Text("Let's Play Triominoes!")
            .font(.title)
            .fontWeight(.bold)
    }
    
    private var startGameButton: some View {
        Text("Start Game")
            .font(.title2)
            .fontWeight(.bold)
            .frame(width: (UIScreen.main.bounds.width - (Constants.padding * 2)), height: 50.0)
            .background(Color(.systemGreen))
            .foregroundStyle(Color(.white))
    }

    
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView(gameData: GameData())
    }
}
