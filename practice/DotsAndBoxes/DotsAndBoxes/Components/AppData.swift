//
//  App.swift
//  DotsAndBoxes
//
//  Created by administrator on 3/28/22.
//

import Foundation
import SwiftUI

class AppData: ObservableObject {
    @Published var runningGame: Game
    @Published var savedGames: [Game]
    @Published var levels: [Level]
    
    init() {
        var endless = Level(name: "Dots & Boxes")
        levels = [
            Level(name: "Level 1"),
            Level(name: "Level 2")
        ]
        savedGames = []
        runningGame = Game(level: endless, mode: 0)
    }
}
