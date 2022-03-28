//
//  App.swift
//  DotsAndBoxes
//
//  Created by administrator on 3/28/22.
//

import Foundation
import SwiftUI

struct AppData {
    var runningGame: Game
    var savedGames: [Game]
    var levels: [Level]
    
    init() {
        levels = [
            Level(name: "Level 1")
        ]
        savedGames = []
        runningGame = Game(level: levels[0], mode: 0)
    }
}
