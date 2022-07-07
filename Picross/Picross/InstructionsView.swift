//
//  InstructionsView.swift
//  Picross
//
//  Created by Andre Lenoir on 5/1/22.
//

import Foundation
import SwiftUI

struct InstructionsView: View
{
    @EnvironmentObject var board: Picross
    var body: some View {
        VStack{
            Text("How to Play: ")
                .font(.system(size: 56.0, weight: .bold))
            Text("Picross (also commonly known as Pic-a-Pix, Nonograms, Griddlers or Paint by Numbers) is a logic puzzle in which squares in a grid are filled in to match numeric clues that appear beside the grid.  Completion of the puzzle results in a satisfying picture formed by the filled squares.\n")
                 
            Text("Picross puzzles look like grids of squares with number clues along the top (columns) and to the left (rows).  The number clues indicate groups of black squares in a row or column; for example, a 5 above a column means that somewhere in that column, there is a group of five black squares with no spaces between them. Grey squares represent a cell which you have determined to be blank\n")

            Text("If there is more than one number clue for a row or column, it means that there are multiple groups of black squares, separated by some number of white squares either before or after the group. To solve the grid, you must find all the filled in squares.\n")
            
            Text("Controlls: ")
                .font(.system(size: 56.0, weight: .bold))
            Text("-Tap a blank cell to fill it in")
            Text("-Double tap a cell to grey it out")
            Text("-To reset a cell you can tap it again")
        }
    }
}
