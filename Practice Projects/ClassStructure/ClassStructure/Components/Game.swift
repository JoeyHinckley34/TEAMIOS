//
//  Game.swift
//  DotsAndBoxes
//
//  Created by administrator on 3/28/22.
//

import Foundation
import SwiftUI

class Game {
    var level: Level
    var mode: Int
    var wave: Int
    var money: Int
    var lives: Int
    var towers: [Tower]
    var enemies: [Enemy]
    
    init(level: Level, mode: Int) {
        self.level = level
        self.mode = mode
        wave = 1
        money = level.startMoney
        lives = level.startLives
        towers = []
        enemies = []
    }
    
    func faceWave() {
        lives -= 1
    }
}
