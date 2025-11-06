//
//  ButtonGridButton.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 11/4/25.
//

import SwiftUI

extension InRoundView {
    
    struct ButtonGridButton: View {
        
        @Bindable var gameData: GameData
        @Binding var path: NavigationPath
        let buttonType: ButtonType
        
        
        
        var body: some View {
            // create empty well toggle
            if buttonType.description == "Empty Well" {
                EmptyWellToggle(gameData: gameData)
            // create end round button
            } else if buttonType.description == "End Round" {
                GameButton(buttonType: buttonType, bgColor: .black, fgColor: .white) { pressedButton in
                    handleButtonPress(pressedButton)
                }
            // create a button for everything else
            } else {
                // create pizza slice button and highlight if toggled
                if gameData.currentFormationBonus == FormationBonuses.pizza.bonus && buttonType.description == "Pizza Slice\n+25" {
                    GameButton(buttonType: buttonType, bgColor: Color(.lightGray), fgColor: .black) { pressedButton in
                        handleButtonPress(pressedButton)
                    }
                // create bridge button and highlight if toggled
                } else if gameData.currentFormationBonus == FormationBonuses.bridge.bonus && buttonType.description == "Bridge\n+40" {
                    GameButton(buttonType: buttonType, bgColor: Color(.lightGray), fgColor: .black) { pressedButton in
                        handleButtonPress(pressedButton)
                    }
                // create hexagon button and highlight if toggled
                } else if gameData.currentFormationBonus == FormationBonuses.hexagon.bonus && buttonType.description == "Hexagon\n+50" {
                    GameButton(buttonType: buttonType, bgColor: Color(.lightGray), fgColor: .black) { pressedButton in
                        handleButtonPress(pressedButton)
                    }
                // create any other buttons
                } else {
                    GameButton(buttonType: buttonType) { pressedButton in
                        handleButtonPress(pressedButton)
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
                    addFormationBonus(button)
                case .bridge:
                    addFormationBonus(button)
                case .hexagon:
                    addFormationBonus(button)
                case .undo:
                    undoMove()
                case .endRound:
                    endRound()
                default:
                    print("This should never run")
                }
            }
        }
    
        private func addScoreAndPass(score: Int) {
            let formationBonus = gameData.currentFormationBonus
            let drawPenalties = gameData.drawPenalties
            let totalTurnScore = formationBonus + drawPenalties + score
            let player = gameData.players[gameData.currentTurn]
            player.addPlayerScore(gameData: gameData, score: totalTurnScore)
            gameData.rounds[gameData.currentRound].addNewMove(move: Move(player: player, scoreAdded: totalTurnScore))
            gameData.nextTurn()
        }
        
        private func drawTriomino() {
            if gameData.wellIsEmpty {
                addScoreAndPass(score: -10)
            } else {
                let player = gameData.players[gameData.currentTurn]
                player.addPlayerScore(gameData: gameData, score: -5)
                gameData.rounds[gameData.currentRound].addNewMove(move: Move(player: player, scoreAdded: -5))
            }
        }
        
        private func addFormationBonus(_ button: ButtonType) {
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
        
        private func undoMove() {
            gameData.rounds[gameData.currentRound].undoLastMove(gameData: gameData)
        }
        
        private func endRound() {
            let winningTurn = gameData.currentTurn == 0 ? gameData.players.count - 1 : gameData.currentTurn - 1
            gameData.currentTurn = winningTurn
            let winningPlayer = gameData.players[winningTurn]
            gameData.rounds[gameData.currentRound].roundWinner = winningPlayer
            path.append(Route.roundEnd)

        }
    
    }
    
}
