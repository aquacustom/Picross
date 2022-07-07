//
//  LeaderBoardView.swift
//  Picross
//
//  Created by Andre Lenoir on 4/13/22.
//

import Foundation
import SwiftUI


struct LeaderBoardView: View
{
    @EnvironmentObject var board: Picross
    var body: some View {
        ScrollView{
            VStack{
                ForEach(Array(board.leaderBoard.keys).sorted(), id: \.self){size in
                    Text(size)
                        .font(.system(size: 56.0, weight: .bold))
                        .foregroundColor(.red)
                    VStack{
                        if board.leaderBoard[size]!.count == 0{
                            Text("None")
                                .font(.system(size: 28.0, weight: .bold))
                                .foregroundColor(.gray)
                        }
                        else if board.leaderBoard[size]!.count <= 10{
                            ForEach(board.leaderBoard[size]!.sorted(), id: \.self){time in
                                Text(String(format: "%d) %02d:%02d", board.leaderBoard[size]!.firstIndex(of: time)! + 1, Int(time / 60), Int(time) % 60))
                                    .font(.system(size: 28.0, weight: .bold))
                                    .foregroundColor(.gray)
                            }
                        }
                        else{
                            ForEach(board.leaderBoard[size]![0...9].sorted(), id: \.self){time in
                                Text(String(format: "%d) %02d:%02d", board.leaderBoard[size]![0...9].firstIndex(of: time)! + 1, Int(time / 60), Int(time) % 60))
                                    .font(.system(size: 28.0, weight: .bold))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                    }
                }
            }
        }
    }
}
