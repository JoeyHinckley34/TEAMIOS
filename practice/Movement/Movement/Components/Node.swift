//
//  Node.swift
//  Movement
//
//  Created by Joey Hinckley on 3/2/22.
//

import Foundation
import SwiftUI

class Node: Identifiable {
    var id = UUID()
    
    var position: CGPoint
    var previousPosition: CGPoint
    var health: CGFloat
    
    var speed: CGPoint
    
    init(position: CGPoint, health : CGFloat){
        self.position = position
        self.previousPosition = .zero
        self.health = health
        self.speed = .zero
    }
}
