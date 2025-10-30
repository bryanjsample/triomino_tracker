//
//  ButtonGrid.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/28/25.
//

import SwiftUI

extension InRoundView {
    
    struct ButtonGrid: View {
        
        @Bindable var gameData:GameData
        
        var body: some View {
            buttonGrid
        }
        
        private var buttonTypes: [[ButtonType]] {
            [[.scoreAction(.wellEmpty), .scoreAction(.draw)],
             [.scoreAction(.pizza), .scoreAction(.bridge), .scoreAction(.hexagon)],
             [.digit(.zero), .digit(.one), .digit(.two), .digit(.three)],
             [.digit(.four), .digit(.five), .digit(.six), .digit(.seven)],
             [.digit(.eight), .digit(.nine), .digit(.ten), .digit(.eleven)],
             [.digit(.twelve), .digit(.thirteen), .digit(.fourteen), .digit(.fifteen)],
             [.scoreAction(.undo), .scoreAction(.new)]]
        }
        
        private var buttonGrid: some View {
            VStack(spacing: Constants.padding) {
                ForEach(buttonTypes, id: \.self) { row in
                    HStack(spacing: Constants.padding) {
                        ForEach(row, id: \.self) { buttonType in
                            // create a toggle for status of the well
                            if buttonType.description == "Empty Well" {
                                EmptyWellToggle(gameData: gameData)
                            } else if buttonType.description == "New Round" {
                                NavigationLink(destination: StartRoundView(gameData: gameData).onAppear {
                                    gameData.nextRound()
                                    let winner = gameData.checkForWinner()
                                    
                                    // logic works and winner is identified at 400 points
                                    // make it to where it automatically goes to a view for 10 seconds saying that person won then totally reset app
                                    
                                    
                                    if winner == "nobody" {
                                        print(winner)
                                    } else {
                                        print(winner)
                                    }
                                }) {
                                    NewRoundButton(gameData: gameData)
                                }
                            } else { // create a button for everything else
                                if gameData.currentFormationBonus == FormationBonuses.pizza.bonus && buttonType.description == "Pizza Slice\n+25" {
                                    GameButton(buttonType: buttonType, bgColor: .gray, fgColor: .black) { pressedButton in
                                        handleButtonPress(pressedButton)
                                    }
                                } else if gameData.currentFormationBonus == FormationBonuses.bridge.bonus && buttonType.description == "Bridge\n+40" {
                                    GameButton(buttonType: buttonType, bgColor: .gray, fgColor: .black) { pressedButton in
                                        handleButtonPress(pressedButton)
                                    }
                                } else if gameData.currentFormationBonus == FormationBonuses.hexagon.bonus && buttonType.description == "Hexagon\n+50" {
                                    GameButton(buttonType: buttonType, bgColor: .gray, fgColor: .black) { pressedButton in
                                        handleButtonPress(pressedButton)
                                    }
                                } else {
                                    GameButton(buttonType: buttonType) { pressedButton in
                                        handleButtonPress(pressedButton)
                                    }
                                }

                            }
                        }
                    }
                }
            }
        }
        
        func handleButtonPress(_ button: ButtonType) {
            switch button {
            case .digit(let digit):
                addScoreAndPass(score: digit.rawValue)
            case .scoreAction(let action):
                switch action {
                case .draw:
                    drawTriomino()
                case .pizza:
                    addFormationBonus(bonus: FormationBonuses.pizza.bonus)
                case .bridge:
                    addFormationBonus(bonus: FormationBonuses.bridge.bonus)
                case .hexagon:
                    addFormationBonus(bonus: FormationBonuses.hexagon.bonus)
                case .undo:
                    gameData.rounds[gameData.currentRound].undoLastMove(gameData: gameData)
                case .new:
                    print("This should never run")
                case .wellEmpty:
                    print("This should never run")
                case .name:
                    print("Implement name tracking for starting turn")
                case .domino0:
                    print(button.description)
                case .domino1:
                    print(button.description)
                case .domino2:
                    print(button.description)
                case .domino3:
                    print(button.description)
                case .domino4:
                    print(button.description)
                case .domino5:
                    print(button.description)
                }
            }
        }
        
        private func addScoreAndPass(score:Int) {
            let formationBonus = gameData.currentFormationBonus
            let drawPenalties = gameData.drawPenalties
            let totalTurnScore = formationBonus + drawPenalties + score
            let player = gameData.players[gameData.currentTurn]
            player.addPlayerScore(score: totalTurnScore)
            gameData.rounds[gameData.currentRound].addNewMove(move: Move(player: player, scoreAdded: totalTurnScore))
            gameData.nextTurn()
        }
        
        private func drawTriomino() {
            if gameData.wellIsEmpty {
                addScoreAndPass(score: -10)
            } else {
                gameData.players[gameData.currentTurn].score -= 5
            }
        }
        
        private func addFormationBonus(bonus:Int) {
            gameData.currentFormationBonus = bonus
        }
        
        private func endRound() {
            let winningPlayer = gameData.players[gameData.currentTurn - 1]
            winningPlayer.addPlayerScore(score: 25)
        }
    }
}
