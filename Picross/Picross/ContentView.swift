//
//  ContentView.swift
//  Picross
//
//  Created by Andre Lenoir on 4/6/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var board: Picross
    @State private var board_height: CGFloat = 25
    @State private var board_width: CGFloat = 25
    
    
    var body: some View {
        TabView{
            VStack(alignment: .center){
                if board.completed{
                    Text("Board Completed!")
                        .font(.system(size: 30.0, weight: .bold))
                        .foregroundColor(.red)
                }
                TimerView()
                    .environmentObject(board)
                BoardView(board_height: $board_height, board_width: $board_width)
                    .environmentObject(board)
                ControllsView(board_height: $board_height, board_width: $board_width)
                    .environmentObject(board)
            }
            .tabItem(){
                Text("Picross")
            }
            LeaderBoardView()
                .environmentObject(board)
                .tabItem(){
                    Text("LeaderBoard")
                }
            InstructionsView()
                .tabItem(){
                    Text("Instructions")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environmentObject(Picross())
        }
    }
}
