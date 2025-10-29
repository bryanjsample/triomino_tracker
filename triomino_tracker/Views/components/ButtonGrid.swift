//
//  ButtonGrid.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 10/28/25.
//

import SwiftUI

extension InGameView {
    
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
             [.scoreAction(.undo), .scoreAction(.edit), .scoreAction(.new)]]
        }
        
        private var buttonGrid: some View {
            VStack(spacing: Constants.padding) {
                ForEach(buttonTypes, id: \.self) { row in
                    HStack(spacing: Constants.padding) {
                        ForEach(row, id: \.self) { buttonType in
                            // create a toggle for status of the well
                            if buttonType.description == "Empty Well" {
                                EmptyWellToggle(gameData: gameData)
                            } else { // create a button for everything else
                                GameButton(buttonType: buttonType) { pressedButton in
                                    handleButtonPress(pressedButton)
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
            case .scoreAction(let action):
                switch action {
                case .draw:
                    drawTriomino()
                case .pizza:
                    addFormationBonus(bonus: 25)
                case .bridge:
                    addFormationBonus(bonus: 40)
                case .hexagon:
                    addFormationBonus(bonus: 50)
                case .undo:
                    print("Better get on that shit")
                case .edit:
                    print("Better get on that shit")
                case .new:
                    print("DO this one")
                case .wellEmpty:
                    print("This should never run")
                }
            }
        }
        
        private func addScoreAndPass(score:Int) {
            let formationBonus = gameData.formationBonus
            let drawPenalties = gameData.drawPenalties
            let totalTurnScore = formationBonus + drawPenalties + score
            gameData.players[gameData.currentTurn].addPlayerScore(score: totalTurnScore)
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
            gameData.formationBonus = bonus
        }
    }
}
