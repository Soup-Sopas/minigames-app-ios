//
//  MinesweeperViewModel.swift
//  FinalProject
//
//  Created by Aquiles Rivero Lopez on 22/02/24.
//

import SwiftUI

final class GridGameViewModel: ObservableObject {
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    
    @Published var bombs: [Int] = [Int]()
    @Published var cells: [Cell?] = Array(repeating: nil, count: 70)
    @Published var hintsMap: [[Int]] = [[Int]]()
    @Published var showBombs: Bool = false
    @Published var title: String = ""
    @Published var isAlertActive: Bool = false
    
    
    func processMove(for i: Int) {
        
        if bombs.contains(i) {
            if cells[i]?.isFlagShown ?? false { return }
            showBombs.toggle()
            title = "You Lost"
            isAlertActive.toggle()
            return
        }
        
        if cells[i]?.isFlagShown ?? false { return }
        
        if bombs.isEmpty {
            let exceptions = getSquaresAround(for: i)
            bombs = Int.getUniqueRandomNumbers(min: 0, max: 70, count: 10, exceptions: exceptions).sorted()
            hintsMap = createHintsMap()
        }
        
        // Uncover the spaces where there is not bombs
        if determineNumberOfBombs(bombs: hintsMap, cellIndex: i) == 0 {
            let grid = toMatrix(cellIndex: i)
            
            let flagsActive = cells.compactMap{ $0 }.filter {$0.isFlagShown == true}
            let indexOfFlags = flagsActive.map { $0.index }
            let emptySpaces = uncoverEmptySpaces(emptySpaces: Set<[Int]>(), hintMap: hintsMap, y: grid["row"]!, x: grid["column"]!)
            
            for emptySpace in emptySpaces {
                let index = (emptySpace[0] * 7) + emptySpace[1]
                
                if indexOfFlags.contains(index) { continue }
                
                cells[index] = Cell(index: index, uncover: false)
                cells[index]?.uncover = true
                cells[index]?.numberOfBombs = determineNumberOfBombs(bombs: hintsMap, cellIndex: index)
            }
        }
        
        
        cells[i] = Cell(index: i, uncover: false)
        cells[i]?.uncover = true
        cells[i]?.numberOfBombs = determineNumberOfBombs(bombs: hintsMap, cellIndex: i)
        
        if cells.compactMap({$0}).filter({$0.uncover == true}).count == 60 {
            showBombs.toggle()
            title = "You win!"
            isAlertActive.toggle()
        }

    }
    
    func alternateBox(cell: Int) -> Bool {
        if cell % 2 == 0 { return true } else { return false }
    }
    
    func getSquaresAround(for cell: Int) -> [Int] {
        var squares = [Int]()
        let grid = toMatrix(cellIndex: cell)
        
        for row in -1..<2 {
            if grid["row"]! + row < 0 || grid["row"]! + row  >= 10 { continue }
            for column in -1..<2 {
                if grid["column"]! + column < 0 || grid["column"]! + column >= 7 { continue }
                let index = (grid["column"]! + column) + ((grid["row"]! + row) * 7)
                squares.append(index)
            }
        }
        
        return squares
    }
   
    // Function to create a map of hints based on the cells' positions
    func createHintsMap() -> [[Int]] {
        var hintsMap: [[Int]] = Array(repeating: Array(repeating: 0, count: 7), count: 10)
        
        for bomb in bombs {
            let grid = toMatrix(cellIndex: bomb)
            hintsMap[grid["row"]!][grid["column"]!] = 9
        }
        
        for row in 0...9 {
            for column in 0...6 {
                if hintsMap[row][column] != 9 {
                    let index = column + (row * 7)
                    hintsMap[row][column] = determineNumberOfBombs(bombs: hintsMap, cellIndex: index)
                    
                }
            }
        }
        
        return hintsMap
    }
    // Function to determine the number of bombs surrounding a cell
    func determineNumberOfBombs(bombs: [[Int]], cellIndex: Int) -> Int {
        
        let grid = toMatrix(cellIndex: cellIndex)

        var bombsCount: Int = 0
        
        for row in -1..<2 {
            if grid["row"]! + row < 0 || grid["row"]! + row  >= 10 { continue }
            for column in -1..<2 {
                if grid["column"]! + column < 0 || grid["column"]! + column >= 7 { continue }
                
                if bombs[grid["row"]! + row][grid["column"]! + column] == 9 {
                    bombsCount+=1
                }
            }
        }
        
        return bombsCount
    }
   
    // Function to convert cell index to row and column
    func toMatrix(cellIndex: Int) -> [String:Int]{
        
        var grid: [String:Int] = [String:Int]()
        
        var cellRow = 0
        var cellColumn = 0
        
        
        for index in 0..<10 {
            if cellIndex >= index * 7 && cellIndex < (index + 1) * 7 {
                cellRow = index
                cellColumn = cellIndex - (cellRow * 7)
                break
            }
        }
        
        grid = ["row": cellRow, "column": cellColumn]
        
        return grid
    }
    
    // Function to recursively uncover empty spaces
    func uncoverEmptySpaces(emptySpaces: Set<[Int]>, hintMap: [[Int]], y: Int, x: Int) -> Set<[Int]> {
        var emptySpaces = emptySpaces
        
        if y < 0 || y >= 10 || x < 0 || x >= 7 || emptySpaces.contains([y,x]) {
            return Set<[Int]>()
        }
        
        if  hintMap[y][x] == 0 {
            emptySpaces.insert([y,x])
            emptySpaces.formUnion(uncoverEmptySpaces(emptySpaces: emptySpaces, hintMap: hintMap, y: (y - 1), x: x))
            emptySpaces.formUnion(uncoverEmptySpaces(emptySpaces: emptySpaces, hintMap: hintMap, y: y, x: (x + 1)))
            emptySpaces.formUnion(uncoverEmptySpaces(emptySpaces: emptySpaces, hintMap: hintMap, y: (y + 1), x: x))
            emptySpaces.formUnion(uncoverEmptySpaces(emptySpaces: emptySpaces, hintMap: hintMap, y: y, x: (x - 1)))
            
        } else if hintMap[y][x] > 0 && hintMap[y][x] != 9 {
            emptySpaces.insert([y,x])
        } else {
            return Set<[Int]>()
        }
        
        
        return emptySpaces
    }
    
    // Function to reset the game state
    func resetGame() {
        
        cells = Array(repeating: nil, count: 70)
        hintsMap = [[Int]]()
        showBombs = false
        bombs = [Int]()

    }
    
   
}

// Struct to represent a cell in the game
struct Cell {
    
    let index: Int
    var uncover: Bool
    var isFlagShown: Bool = false
    var numberOfBombs: Int = 0
    
    var numberOrFlag: String {
        if uncover && !isFlagShown {
            return String(numberOfBombs)
        }
        return isFlagShown ? "flag" : ""
    }
}

// Extension to generate unique random numbers within a range
extension Int {
    static func getUniqueRandomNumbers(min: Int, max: Int, count: Int, exceptions: [Int]) -> [Int] {
        var set = Set<Int>()
        while set.count < count {
            var randomNumber = Int.random(in: min...max)
            while exceptions.contains(randomNumber) {
                randomNumber = Int.random(in: min...max)
            }
            set.insert(randomNumber)
        }
        return Array(set)
    }
}
