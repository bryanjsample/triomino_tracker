//
//  RoundEndView.swift
//  triomino_tracker
//
//  Created by Bryan Sample on 11/2/25.
//

import SwiftUI

struct RoundEndView: View {
    
    @Bindable var gameData: GameData
    @Binding var path: NavigationPath
    @State var bonuses: [Player:Int] = [:]
    @State var winBonus: Int = 25
    
    var body: some View {
        VStack {
            Scoreboard(gameData: gameData)
            Spacer()
            roundWinnerText
            roundLoserNames
            roundLoserScores
            Spacer()
            nextRoundButton
        }.navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backToRoundButton
                }
            }
    }
    
    private var backToRoundButton: some View {
            Button("Back", systemImage: "chevron.left") {
                let previousTurn = gameData.currentTurn == gameData.players.count - 1 ? 0 : gameData.currentTurn + 1
                gameData.currentTurn = previousTurn
                path.removeLast()
            }
    }
    
    private var roundWinnerText: some View {
        VStack {
            Text("\(getRoundWinner()?.name ?? "Nobody") won the round! 🎉")
                .font(.system(size: 30.0, weight: .bold))
            Text("+\(winBonus) points")
                .font(.system(size: 15.0, weight: .bold))
        }

    }
    
    private var roundLoserNames: some View {
        HStack {
            ForEach(gameData.players, id: \.self) { player in
                if player.name != getRoundWinner()?.name {
                    Text(player.name)
                        .font(.system(size: 20.0, weight: .medium))
                        .frame(
                            width:HelperFuncs.getButtonSize(buttonCount: CGFloat(gameData.players.count - 1)),
                            height:(HelperFuncs.getButtonSize(buttonCount: 4.0) / 2)
                        )
                        .background(.black)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: Constants.padding))
                        .padding(.top, Constants.padding)
                }
            }
        }
    }
    
    private var roundLoserScores: some View {
        HStack {
            ForEach(getRoundLosers(), id: \.self) { player in
                TextField("Extra points", text: Binding(projectedValue: bindingForPlayer(player)))
                    .padding(Constants.padding)
                    .keyboardType(.numberPad)
                    .frame(width: HelperFuncs.getButtonSize(buttonCount: CGFloat(gameData.players.count - 1)))
                    .font(.system(size: 15.0, weight: .medium))
                    .multilineTextAlignment(.center)
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: Constants.padding))
                }
            
        }
    }
    
    private func bindingForPlayer(_ player: Player) -> Binding<String> {
        Binding<String>(
            get: {
                if let value = bonuses[player] {
                    return String(value)
                } else {
                    return ""
                }
            },
            set: { newValue in
                if let val = Int(newValue) {
                    bonuses[player] = val
                }
                updateWinBonus()
            }
        )
    }
    
    private func updateWinBonus() {
        winBonus = bonuses.values.reduce(25, +)
    }

    private var nextRoundButton: some View {
        GameButton(buttonType: ButtonType.gameAction(.startRound)) { _ in
            
            if let winningPlayer = getRoundWinner() {
                winningPlayer.addPlayerScore(score: winBonus)
            }
            gameData.nextRound()
            path.append(Route.startRound)
            
        }.padding(.horizontal, Constants.padding)
            .fontWeight(.bold)
    }
    
    private func getRoundWinner() -> Player? {
        gameData.rounds[gameData.currentRound].roundWinner
    }
    
    private func getRoundLosers() -> [Player] {
        gameData.players.filter { $0.name != getRoundWinner()?.name }
    }
    
}

struct RoundEndView_Previews: PreviewProvider {
    static var previews: some View {
        @State var previewData = GameData()
        @State var path = NavigationPath()
        
        RoundEndView(gameData: previewData, path: $path).onAppear {
            let winnerPlayer = Player(name: "Kelissa", score: 0)
            previewData.addPlayer(Player(name: "Richie", score: 0))
            previewData.addPlayer(Player(name: "Bryan", score: 0))
            previewData.addPlayer(winnerPlayer)
            previewData.rounds[previewData.currentRound].roundWinner = winnerPlayer
        }
    }
}
