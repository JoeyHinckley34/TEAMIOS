//
//  DotsAndBoxesApp.swift
//  DotsAndBoxes
//
//  Created by administrator on 4/8/22.
//

import SwiftUI

// Main Game Driver
@main
struct DotsAndBoxesApp: App {
    @State var showGame = false
    var body: some Scene {
        WindowGroup {
           Menu("Menu") {
                Button("Start", action: start)
                Button("Exit to menu", action: menu)
            }
            if(showGame){
                ContentView() // game engine
            }
        }
    }
    func start() { showGame = true  }
    func menu()  { showGame = false }
}
