//
//  Game.swift
//  GroupProject

import Foundation

/* colortile + mode enums for determining what colors we want to use */
public enum ColorTile: Int {
    case White = 0
    case Black = 1
    case Gray = 2
}

/* actual game */
class Picross: ObservableObject{
    @Published var playerBoard: [[Int]] = [[]]
    @Published var row_size: Int
    @Published var col_size: Int
    @Published var sec: Double
    @Published var completed: Bool
    @Published var saved_score:Bool
    @Published var leaderBoard: [String:[Double]]
    let defaults: UserDefaults = UserDefaults.standard
    var finalBoard:  [[Int]] =  [[]]
    
    /* creates new game of a row x col board
       Starting row and column size is 10*/
    init(){
        leaderBoard = defaults.value(forKey: "leaderBoard") as? [String:[Double]] ?? ["5x5": [], "10x5": [], "10x10": [], "15x10": [], "15x15": []]
        saved_score = defaults.bool(forKey: "saved_score")
        sec = defaults.double(forKey: "sec")
        completed = defaults.bool(forKey: "completed")
        row_size = defaults.object(forKey: "row_size") as? Int ?? 10
        col_size = defaults.object(forKey: "col_size") as? Int ?? 10
        finalBoard = defaults.object(forKey: "finalBoard") as? [[Int]] ?? [[]]
        playerBoard = defaults.object(forKey: "playerBoard") as? [[Int]] ?? [[]]
        
        if playerBoard == [[]]{
            createRandomGame()
        }
    }
    
    //Function to clear the board, for the reset button
    func clearBoard () {
        sec = 0
        completed = false
        saved_score = false
        for i in 0..<row_size
        {
            for j in 0..<col_size
            {
                playerBoard[i][j] = ColorTile.White.rawValue           }
        }
        defaults.set(playerBoard, forKey: "playerBoard")
        defaults.set(completed, forKey: "completed")
        defaults.set(saved_score, forKey: "saved_score")
        defaults.set(sec, forKey: "sec")
    }
    
    func incrementTimer(){
        sec += 0.1
        defaults.set(sec, forKey: "sec")
    }
    
    func setSize(_ row: Int, _ col: Int){
        row_size = row
        col_size = col
        defaults.set(row_size, forKey: "row_size")
        defaults.set(col_size, forKey: "col_size")
    }
    
    func createRandomGame(){
        completed = false
        saved_score = false
        sec = 0
        playerBoard = Array(repeating: Array(repeating: ColorTile.White.rawValue, count: col_size), count: row_size)
        finalBoard  = Array(repeating: Array(repeating: ColorTile.White.rawValue, count: col_size), count: row_size)
        
        for i in 0..<row_size {
            for j in 0..<col_size {
                finalBoard[i][j] = Int.random(in: 0..<2)
            }
        }
        defaults.set(completed, forKey: "completed")
        defaults.set(saved_score, forKey: "saved_score")
        defaults.set(playerBoard, forKey: "playerBoard")
        defaults.set(finalBoard, forKey: "finalBoard")
        defaults.set(sec, forKey: "sec")
    }
        
    /* updates player board at position (x,y) with a color. */
    func updateBoard(_ x: Int, _ y: Int, _ color: ColorTile){
        playerBoard[x][y] = color.rawValue
        defaults.set(playerBoard, forKey: "playerBoard")
        completed = checkComplete()
        defaults.set(completed, forKey: "completed")
    }
    
    func saveScore(){
        let size = String(format: "%dx%d", row_size, col_size)
        if !saved_score{
            leaderBoard[size]!.append(sec)
            leaderBoard[size]!.sort()
            saved_score = true
            defaults.set(leaderBoard, forKey: "leaderBoard")
            defaults.set(saved_score, forKey: "saved_score")
        }
    }

    /* Function to test if a board is complete */
    func checkComplete() -> Bool {
        for i in 0..<row_size
        {
            let str1: String = getRowString(playerBoard, i)

            if  (getRowString(finalBoard, i) != str1)
            {
                return false
            }
        }
        for j in 0..<col_size
        {
            let str2: String = getColString(playerBoard, j)
            if (getColString(finalBoard, j) != str2)
            {
                return false
            }
        }
        return true
    }

    
    func getRowString(_ board: [[Int]], _ row: Int) -> String {
        var str = ""
        var count = 0;
        for i in 0..<col_size{
            if(board[row][i] == ColorTile.Black.rawValue)
            {
                count += 1
            }
            else if (count > 0)
            {
                str += "\(count)  "
                count = 0
            }
        }
        
        if(count > 0){
            str += "\(count)"
        }
        
        if(str == ""){
            str = "0"
        }
        
        return str.trimmingCharacters(in: .whitespacesAndNewlines) + "\t";
    }
    
    func getColString(_ board:[[Int]], _ col: Int) -> String {
        var str = ""
        
        var count = 0
        
        for i in 0..<row_size {
            if(board[i][col] != ColorTile.Black.rawValue){
                if(count > 0){
                    str += "\(count)\n"
                    count = 0
                }
            }
            
            else{
                count += 1
            }
        }
        
        if(count > 0){
            str += "\(count)"
        }
        
        if(str == ""){
            str = "0"
        }
        
        return str.trimmingCharacters(in: .whitespacesAndNewlines) + "\t";
    }
    
}
