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
    
    @State var position: CGPoint
    @State var previousPosition: CGPoint
    @State var health: CGFloat
    
    var speed: CGPoint
    
    init(position: CGPoint, health : CGFloat){
        self.position = position
        self.previousPosition = .zero
        self.health = health
        self.speed = .zero
    }
    
    init(){
        self.position = CGPoint(x: UIScreen.main.bounds.width/2, y:.zero-10)
        self.previousPosition = .zero
        self.health = 10
        self.speed = .zero
    }
    
}
