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
    @State var lvl: Int = 0
    var body: some Scene {
        WindowGroup {
           Menu("Menu") {
               Button("Endless", action: endless)
               Button("Level 1", action: lvl1)
               Button("Level 2", action: lvl2)
               Button("Level 3", action: lvl3)
               Button("Exit to menu", action: menu)
            }
            if showGame {
                ContentView(lvl: lvl) // game engine
            }
        }
    }
    func endless() {
        showGame = true
        lvl = 0
    }
    func lvl1() {
        showGame = true
        lvl = 1
    }
    func lvl2() {
        showGame = true
        lvl = 2
    }
    func lvl3() {
        showGame = true
        lvl = 3
    }
    func menu() { showGame = false }
}
