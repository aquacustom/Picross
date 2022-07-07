//
//  BoardView.swift
//  Picross
//
//  Created by Andre Lenoir on 4/6/22.
//

import SwiftUI

struct BoardView: View
{
    @EnvironmentObject var board: Picross
    @Binding var board_height: CGFloat
    @Binding var board_width: CGFloat
    @State var counter = 0
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0){
            renderRowStr()
            VStack(spacing:0){
                renderColStr()
                renderBoard()
            }
            
        }
    }
    
    func renderColStr() -> some View{
        var txt: some View{
            HStack(spacing: 0){
                ForEach(0..<board.col_size, id: \.self){ col in
                    Text("\(board.getColString(board.finalBoard, col))")
                        .frame(width: board_width)
                }
            }
        }
        return txt
    }
    
    func renderRowStr() -> some View{
        var txt: some View{
            VStack(spacing: 0){
                ForEach(0..<board.row_size, id: \.self){ row in
                    Text("\(board.getRowString(board.finalBoard, row))")
                        .frame( height: board_height, alignment: .trailing)
                }
            }
        }
        return txt
    }
    
    func renderBoard() -> some View{
        let (height, width): (CGFloat, CGFloat) = size_table[String(format:"%dx%d", board.row_size, board.col_size)]!
        board_height = height
        board_width = width
        var b: some View{
            VStack(spacing: 0){
                ForEach(0..<board.row_size, id: \.self){ row in
                    HStack(spacing: 0){
                        ForEach(0..<board.col_size, id: \.self){ col in
                            switch board.playerBoard[row][col]{
                            case ColorTile.Black.rawValue:
                                    Rectangle()
                                        .frame(width: board_width, height: board_height)
                                        .foregroundColor(.black)
                                        .border(.black)
                                        .onTapGesture(count: 2){
                                            board.updateBoard(row, col, .Gray)
                                        }

                                        .onTapGesture(count: 1){
                                            board.updateBoard(row, col, .White)
                                        }
                            case ColorTile.Gray.rawValue:
                                    Rectangle()
                                        .frame(width: board_width, height: board_height)
                                        .foregroundColor(.gray)
                                        .border(.black)
                                        .onTapGesture(count: 2){
                                            board.updateBoard(row, col, .Black)
                                        }
                                        .onTapGesture(count: 1){
                                            board.updateBoard(row, col, .White)
                                        }
                                default:
                                    Rectangle()
                                        .frame(width: board_width, height: board_height)
                                        .foregroundColor(.white)
                                        .border(.black)
                                        .onTapGesture(count: 2){
                                            board.updateBoard(row, col, .Gray)
                                        }
                                        .onTapGesture(count: 1){
                                            board.updateBoard(row, col, .Black)
                                        }
                            }
                        }
                    }
                }
            }
        }
        if board.completed && !board.saved_score{
            board.saveScore()
        }
        return b
    }

}

