//
//  Node.swift
//  DotsAndBoxes
//
//  Created by Joey Hinckley on 3/1/22.
//

import Foundation
import SwiftUI

class Node: Identifiable {
    var id = UUID()

    var position: CGPoint
    var previousPosition: CGPoint
    
    
    var health: CGFloat
    

    init(position: CGPoint, health: CGFloat) {
        self.position = position
        self.previousPosition = .zero
        
        self.health = health
    }
}
