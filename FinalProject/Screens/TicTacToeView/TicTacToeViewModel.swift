//
//  TicTacToeViewModel.swift
//  FinalProject
//
//  Created by Aquiles Rivero Lopez on 22/02/24.
//

import SwiftUI

final class TicTacToeViewModel: ObservableObject {
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isTaken = Array<Bool>(repeating: false, count: 9)
    @Published var isBoardDisabled = false
    @Published var alertItem: AlertItem?
    @Published var isAlertActive: Bool = false
    
    func processMove(for i: Int) {
        // Human Move
        if !isTaken[i] {
            moves[i] = Move(player: .human, index: i)
            isTaken[i] = true
        } else { return }
        
        if checkWinCondition(player: .human, moves: moves) {
            alertItem = AlertContext.humanWin
            isAlertActive = true
            return
        }
        
        if isTaken.allSatisfy({ $0 == true }) {
            alertItem = AlertContext.draw
            isAlertActive = true
            return
        }
        
        isBoardDisabled = true
        
        // Computer Move
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            let position = determineComputerPosition(moves: moves)
            
            moves[position] = Move(player: .computer, index: position)
            isTaken[position] = true
            isBoardDisabled = false
            if checkWinCondition(player: .computer, moves: moves) {
                alertItem = AlertContext.computerWin
                isAlertActive = true
                return
            }
            if isTaken.allSatisfy({ $0 == true }) {
                alertItem = AlertContext.draw
                isAlertActive = true
                return
            }
        }
    }
    
    func determineComputerPosition(moves: [Move?]) -> Int {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8],
                                          [0,3,6], [1,4,7], [2,5,8],
                                          [0,4,8], [2,4,6]]
        
        // Filters all non nil moves and computer moves, then it saves the index of those moves
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer}
        let computerPosition = Set(computerMoves.map { $0.index })
        // Goes through every win pattern and subtract the computer positions played so far, to get one pattern where there is only 1 move to win
        for pattern in winPatterns {
            let winPosition = pattern.subtracting(computerPosition)
            
            if winPosition.count == 1 {
                let isAvailabe = !isTaken[winPosition.first!]
                if isAvailabe { return winPosition.first! }
            }
        }
        // Does the same did before but with the human moves to determine the position to block
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human}
        let humanPosition = Set(humanMoves.map { $0.index })
        
        for pattern in winPatterns {
            let blockPosition = pattern.subtracting(humanPosition)
            
            if blockPosition.count == 1 {
                let isAvailabe = !isTaken[blockPosition.first!]
                if isAvailabe { return blockPosition.first! }
            }
        }
        
        let centerSquare = 4
        if !isTaken[centerSquare] { return centerSquare }
        
        var position = Int.random(in: 0..<9)
        
        while isTaken[position] {
            position = Int.random(in: 0..<9)
        }
        
        return position
    }
    
    func checkWinCondition(player: Player, moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8],
                                          [0,3,6], [1,4,7], [2,5,8],
                                          [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player}
        let playerPosition = Set(playerMoves.map { $0.index })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPosition) { return true }
        
        return false
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        isTaken = Array<Bool>(repeating: false, count: 9)
    }
}
