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
        @Binding var path : NavigationPath
        
        var body: some View {
            buttonGrid
        }
        
        private var buttonTypes: [[ButtonType]] {
            [[.gameAction(.wellEmpty), .gameAction(.draw)],
             [.gameAction(.pizza), .gameAction(.bridge), .gameAction(.hexagon)],
             [.digit(.zero), .digit(.one), .digit(.two), .digit(.three)],
             [.digit(.four), .digit(.five), .digit(.six), .digit(.seven)],
             [.digit(.eight), .digit(.nine), .digit(.ten), .digit(.eleven)],
             [.digit(.twelve), .digit(.thirteen), .digit(.fourteen), .digit(.fifteen)],
             [.gameAction(.undo), .gameAction(.new)]]
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
                                
                                GameButton(buttonType: buttonType, bgColor: .black, fgColor: .white) { pressedButton in
                                    endRound()
                                    gameData.nextRound()
                                    let winner = gameData.checkForWinner()
                                    if winner != "nobody" {
                                        gameData.winner = winner
                                        while path.count > 0 {
                                            path.removeLast()
                                        }
                                        gameData.resetGame()
                                    } else {
                                        path.append(Route.startRound)
                                    }
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
        
        private func handleButtonPress(_ button: ButtonType) {
            switch button {
            case .digit(let digit):
                addScoreAndPass(score: digit.rawValue)
            case .gameAction(let action):
                switch action {
                case .draw:
                    drawTriomino()
                case .pizza:
                    addFormationBonus(button: button)
                case .bridge:
                    addFormationBonus(button: button)
                case .hexagon:
                    addFormationBonus(button: button)
                case .undo:
                    gameData.rounds[gameData.currentRound].undoLastMove(gameData: gameData)
                default:
                    print("This should never run")
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
        
        private func addFormationBonus(button: ButtonType) {
            if button.description == "Pizza Slice\n+25" {
                if gameData.currentFormationBonus == FormationBonuses.pizza.bonus {
                    gameData.currentFormationBonus = 0
                } else {
                    gameData.currentFormationBonus = FormationBonuses.pizza.bonus
                }
            } else if button.description == "Bridge\n+40" {
                if gameData.currentFormationBonus == FormationBonuses.bridge.bonus {
                    gameData.currentFormationBonus = 0
                } else {
                    gameData.currentFormationBonus = FormationBonuses.bridge.bonus
                }
            } else if button.description == "Hexagon\n+50" {
                if gameData.currentFormationBonus == FormationBonuses.hexagon.bonus {
                    gameData.currentFormationBonus = 0
                } else {
                    gameData.currentFormationBonus = FormationBonuses.hexagon.bonus
                }
            }
        }
        
        private func endRound() {
            let winningTurn = gameData.currentTurn == 0 ? gameData.players.count - 1 : gameData.currentTurn - 1
            let winningPlayer = gameData.players[winningTurn]
            winningPlayer.addPlayerScore(score: 25)
        }
    }
}

