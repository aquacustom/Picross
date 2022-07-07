//
//  PicrossApp.swift
//  Picross
//
//  Created by Andre Lenoir on 4/6/22.
//

import SwiftUI

@main
struct PicrossApp: App {
    @StateObject var board: Picross = Picross()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(board)
        }
    }
}
