//
//  Tower.swift
//  DotsAndBoxes
//
//  Created by administrator on 3/28/22.
//

import Foundation
import SwiftUI

struct Tower: Identifiable {
    var id: UUID
    var position: CGPoint
    var range: CGFloat
    var damage: Int
    var cooldown: Int
}
