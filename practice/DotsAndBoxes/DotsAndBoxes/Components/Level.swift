//
//  Level.swift
//  DotsAndBoxes
//
//  Created by administrator on 3/28/22.
//

import Foundation
import SwiftUI

struct Level: Codable {
    var name: String
    var path: [CGPoint]
    var waves: [Wave]
    var startMoney: Int
    var startLives: Int
    
    init(name: String) {
        self.name = name
        path = [
            CGPoint(x: UIScreen.main.bounds.width/2, y: .zero),
            CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)
        ]
        waves = [
            Wave(count: 10, delay: 5),
            Wave(count: 15, delay: 1)
        ]
        startMoney = 100
        startLives = 10
    }
}
