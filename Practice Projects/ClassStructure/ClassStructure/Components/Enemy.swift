//
//  Enemy.swift
//  DotsAndBoxes
//
//  Created by administrator on 3/28/22.
//

import Foundation
import SwiftUI

struct Enemy: Identifiable {
    var id: UUID
    var path: [CGPoint]
    var position: CGPoint
    var speed: CGFloat
    var health: Int
    var drops: Int
}
