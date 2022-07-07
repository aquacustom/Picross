//
//  TimerView.swift
//  Picross
//
//  Created by Andre Lenoir on 4/6/22.
//

import SwiftUI

struct TimerView: View
{
    @EnvironmentObject var board: Picross
    @Environment(\.scenePhase) var scenePhase
    @State private var timerColor: Color = .red
    @State private var isActive = true
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(String(format: "%02d:%02d", Int(board.sec / 60), Int(board.sec) % 60))
            .font(.system(size: 36.0, weight: .bold))
            .foregroundColor(timerColor)
            .onReceive(timer){_ in
                guard isActive else { return }
                if board.completed{
                    if timerColor == .red{
                        timerColor = .blue
                    }
                    else{
                        timerColor = .red
                    }
                }
                else{
                    timerColor = .red
                    board.incrementTimer()
                }
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    isActive = true
                }
                else {
                    isActive = false
                }
                
            }
    }
}
