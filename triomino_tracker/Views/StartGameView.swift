//
//  StartGameView.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import SwiftUI
import Observation


struct StartGameView: View {
    
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
                NavigationLink(destination: StartRoundView(gameData: gameData).onAppear {
                    addPlayers()
                } ) {
                    startGameButton
                }
                Spacer()
            }
        }.navigationTitle("")
            .toolbar(.hidden)
    }
}

extension StartGameView {
    
    private var playerNameInputFields: some View {
        VStack(spacing:Constants.padding) {
            TextField("Player One", text: $playerOneName)
                .textFieldStyle(NameEntryStyle())
            TextField("Player Two", text: $playerTwoName)
                .textFieldStyle(NameEntryStyle())
            TextField("Player Three", text: $playerThreeName)
                .textFieldStyle(NameEntryStyle())
            TextField("Player Four", text: $playerFourName)
                .textFieldStyle(NameEntryStyle())
        }
    }
    
    private var pageTitle: Text {
        Text("Let's Play Triominoes!")
            .font(.title)
            .fontWeight(.bold)
    }
    
    private var startGameButton: some View {
        Text("Start Game")
            .font(.title)
            .fontWeight(.bold)
            .frame(
                width: HelperFuncs.getButtonSize(buttonCount: 1.0),
                height: HelperFuncs.getButtonSize(buttonCount: 6.0)
            )
            .background(.black)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: Constants.padding))
    }

    func addPlayers() {
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
    }
}

struct StartGameView_Previews: PreviewProvider {
    static var previews: some View {
        StartGameView(gameData: GameData())
    }
}
