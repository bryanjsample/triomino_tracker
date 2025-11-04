//
//  StartGameView.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/24/25.
//

import SwiftUI
import Observation


struct StartGameView: View {
    
    @State var gameData = GameData()
    @State var path = NavigationPath()
    @State private var showAlert = false
    
    @State private var playerOneName: String = ""
    @State private var playerTwoName: String = ""
    @State private var playerThreeName: String = ""
    @State private var playerFourName: String = ""
    
    @State var playerOne: Player = Player(name: "", score: 0)
    @State var playerTwo: Player = Player(name: "", score: 0)
    @State var playerThree: Player = Player(name: "", score: 0)
    @State var playerFour: Player = Player(name: "", score: 0)
    
    var body: some View {
        
        NavigationStack(path: $path) {
            VStack(spacing:Constants.padding) {
                Spacer()
                pageTitle
                playerNameInputFields
                startGameButton
                Spacer()
            }.navigationDestination(for: Route.self) { newView in
                switch newView {
                case .startGame:
                    StartGameView()
                case .startRound:
                    StartRoundView(gameData: gameData, path: $path)
                case .inRound:
                    InRoundView(gameData: gameData, path: $path)
                case .roundEnd:
                    RoundEndView(gameData: gameData, path: $path)
                case .gameEnd:
                    GameEndView(gameData: gameData, path: $path)
               
        } }
        }
        .navigationTitle("")
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
        
        GameButton(buttonType: ButtonType.gameAction(.startGame)) { pressedButton in
            
            startGame()
            
        }.padding(.horizontal, Constants.padding)
            .fontWeight(.bold)
            .alert("Missing Player Names", isPresented: $showAlert) {
                Button("Ok", role: .cancel) { }
            } message: {
                Text("Please enter at least two player names before starting the game")
            }
    }
    
    private func startGame() {
        addPlayers()
        if gameData.players.count < 2 {
            showAlert = true
            gameData.players.removeAll()
        } else {
            path.append(Route.startRound)
        }
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
