//
//  Enemy.swift
//  TapForNewView
//
//  Created by Joey Hinckley on 3/23/22.
//
import Foundation
import SwiftUI

class Enemy: Identifiable {
    var id = UUID()
    
    var position: CGPoint
    var previousPosition: CGPoint
    var health: CGFloat
    
    init(position: CGPoint, health : CGFloat){
        self.position = position
        self.previousPosition = .zero
        self.health = health
    }
}
