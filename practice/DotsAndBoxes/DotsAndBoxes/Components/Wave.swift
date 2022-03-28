//
//  Wave.swift
//  DotsAndBoxes
//
//  Created by administrator on 3/28/22.
//

import Foundation
import SwiftUI

struct Wave: Codable {
    var enemyTypes: [Int]
    var cyclesBetween: [Int]
    
    init(count: Int, delay: Int) {
        enemyTypes = []
        cyclesBetween = []
        for _ in 0...count {
            enemyTypes.append(1)
            cyclesBetween.append(delay)
        }
    }
}
