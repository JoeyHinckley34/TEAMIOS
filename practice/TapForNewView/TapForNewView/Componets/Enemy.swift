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
    
    var location: CGPoint
    var previousLocation: CGPoint
    var health: CGFloat
    
    init(position: CGPoint, health : CGFloat){
        self.location = position
        self.previousLocation = .zero
        self.health = health
    }
    
}
