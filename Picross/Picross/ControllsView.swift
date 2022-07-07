//
//  ControllsView.swift
//  Picross
//
//  Created by Andre Lenoir on 4/8/22.
//

import Foundation
import SwiftUI
var size_table:[String:(CGFloat,CGFloat)] = ["5x5": (40,40), "10x5": (35,35), "10x10": (25,25), "15x10": (22,22), "15x15": (15,15)]

var board_sizes: [String:(Int,Int)] = ["5x5":(5,5), "10x5": (5,10), "10x10": (10,10), "15x10": (10,15), "15x15": (15,15)]

struct ControllsView: View
{
    
    @EnvironmentObject var board: Picross
    @Binding var board_height: CGFloat
    @Binding var board_width: CGFloat
    @State var cur_size: String = "10x10"

    var body: some View {
        VStack{
            HStack{
                Text("Board Size:")
                    .padding()
                Picker("Board Size:", selection: $cur_size){
                    ForEach(Array(board_sizes.keys).sorted(), id: \.self){ size in
                        Text("\(size)")
                    }
                }
            }
            Button("Reset"){
                board.clearBoard()
            }
                .buttonStyle(.bordered)
                .tint(.blue)
            Button("New Game"){
                let (height, width): (CGFloat, CGFloat) = size_table[cur_size]!
                board_height = height
                board_width = width
                let (col, row): (Int, Int) = board_sizes[cur_size]!
                board.setSize(row, col)
                board.createRandomGame()
            }
                .buttonStyle(.bordered)
                .tint(.blue)
        }
    }
}
