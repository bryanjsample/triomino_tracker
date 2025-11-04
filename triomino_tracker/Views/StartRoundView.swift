//
//  StartRoundView.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/29/25.
//

import SwiftUI

struct StartRoundView: View {
    
    @Bindable var gameData: GameData
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            Spacer()
            playerButtons
            Scoreboard(gameData: gameData).scoreboardScores.padding(.bottom, Constants.padding)
            dominoButtons
            startRoundButton
            Spacer()
        }.navigationTitle("")
            .toolbar(.hidden)
    }
}



struct StartRoundView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        @State var previewData = GameData()
        @State var path = NavigationPath()
        
        StartRoundView(gameData: previewData, path: $path).onAppear {
            previewData.addPlayer(Player(name: "Richie", score: 0))
            previewData.addPlayer(Player(name: "Kelissa", score: 0))
            previewData.addPlayer(Player(name: "Bryan", score: 0))
            previewData.addPlayer(Player(name: "Kiku", score: 0))
        }
    }
}

extension StartRoundView {
    
    var playerButtons: some View {
        HStack {
            ForEach(gameData.players, id: \.self) { player in
                GameButton(
                    buttonType: ButtonType.gameAction(.name),
                    buttonLabel: player.name,
                    bgColor: gameData.players.firstIndex(of: player) == gameData.currentTurn ? .gray : .black,
                    fgColor: gameData.players.firstIndex(of: player) == gameData.currentTurn ? .black : .white
                    
                ) { pressedButton in
                    setStartingPlayer(button: pressedButton, player: player)
                }
            }
        }.padding(.horizontal, Constants.padding)
    }
    
    private var buttonGrid: [[ButtonType]] {
        [[.gameAction(.domino0), .gameAction(.domino1)],
         [.gameAction(.domino2), .gameAction(.domino3)],
         [.gameAction(.domino4), .gameAction(.domino5)]]
    }
    
    var dominoButtons: some View {
        VStack {
            ForEach(buttonGrid, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { domino in
                        GameButton(
                            buttonType: domino,
                            bgColor: gameData.rounds[gameData.currentRound].startingPoints == domino.pointValue ? .gray : .black,
                            fgColor: gameData.rounds[gameData.currentRound].startingPoints == domino.pointValue ? .black : .white
                        ) { pressedButton in
                            setStartingPoints(button: pressedButton)
                        }
                    }
                }.padding(.horizontal, Constants.padding)
            }
        }
    }
    
    private var startRoundButton: some View {
        GameButton(buttonType: ButtonType.gameAction(.startRound)) { pressedButton in
            
            startRound()
            path.append(Route.inRound)
            
        }.padding(.horizontal, Constants.padding)
            .fontWeight(.bold)
    }
    
    func setStartingPlayer(button: ButtonType, player: Player) {
        let startingPlayerIndex = gameData.players.firstIndex(of: player) ?? 0
        gameData.currentTurn = startingPlayerIndex
    }
    
    func setStartingPoints(button: ButtonType) {
        let currentRound: RoundData = gameData.rounds[gameData.currentRound]
        switch button {
        case .gameAction(.domino0):
            currentRound.setStartingPoints(40)
        case .gameAction(.domino1):
            currentRound.setStartingPoints(13)
        case .gameAction(.domino2):
            currentRound.setStartingPoints(16)
        case .gameAction(.domino3):
            currentRound.setStartingPoints(19)
        case .gameAction(.domino4):
            currentRound.setStartingPoints(22)
        case .gameAction(.domino5):
            currentRound.setStartingPoints(25)
        default:
            return
        }
    }
    
    func startRound() {
        let player = gameData.players[gameData.currentTurn]
        let score = gameData.rounds[gameData.currentRound].startingPoints
        player.addPlayerScore(score: score)
        gameData.rounds[gameData.currentRound].addNewMove(move: Move(player: player, scoreAdded: score))
        gameData.nextTurn()
    }
}
