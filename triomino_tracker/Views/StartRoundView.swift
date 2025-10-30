//
//  StartRoundView.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/29/25.
//

import SwiftUI

struct StartRoundView: View {
    
    @Bindable var gameData: GameData
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                playerButtons
                Scoreboard(gameData: gameData).scoreboardScores.padding(.bottom, Constants.padding)
                dominoButtons
                NavigationLink(destination: InRoundView(gameData: gameData).onAppear {
                    startRound()
                }) {
                    starRoundButton
                }
                Spacer()
            }
        }.navigationTitle("")
            .toolbar(.hidden)
    }
}


struct StartRoundView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        @State var previewData = GameData()
        
        StartRoundView(gameData: previewData).onAppear {
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
                    buttonType: ButtonType.scoreAction(.name),
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
        [[.scoreAction(.domino0), .scoreAction(.domino1)],
         [.scoreAction(.domino2), .scoreAction(.domino3)],
         [.scoreAction(.domino4), .scoreAction(.domino5)]]
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
    
    var starRoundButton: some View {
        Text("Start Round")
            .font(.system(size: 25.0, weight: .bold))
            .frame(
                width: HelperFuncs.getButtonSize(buttonCount: 1.0),
                height: HelperFuncs.getButtonSize(buttonCount: 4.0)
            )
            .background(.black)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: Constants.padding))
            .padding(.vertical, Constants.padding)

    }
    
    func setStartingPlayer(button: ButtonType, player: Player) {
        let startingPlayerIndex = gameData.players.firstIndex(of: player) ?? 0
        gameData.currentTurn = startingPlayerIndex
    }
    
    func setStartingPoints(button: ButtonType) {
        let currentRound: RoundData = gameData.rounds[gameData.currentRound]
        switch button {
        case .scoreAction(.domino0):
            currentRound.setStartingPoints(40)
            print(String(gameData.rounds.count))
        case .scoreAction(.domino1):
            currentRound.setStartingPoints(13)
        case .scoreAction(.domino2):
            currentRound.setStartingPoints(16)
        case .scoreAction(.domino3):
            currentRound.setStartingPoints(19)
        case .scoreAction(.domino4):
            currentRound.setStartingPoints(22)
        case .scoreAction(.domino5):
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
