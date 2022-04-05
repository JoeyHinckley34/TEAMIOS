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
    var isDead: Bool
    
    init(position: CGPoint, health : CGFloat){
        self.location = position
        self.previousLocation = .zero
        self.health = health
        isDead = false
    }
    
    func move(){
        //off screen
        if(location.y > UIScreen.main.bounds.height+10){
            location.y = -10
            //Lives -= 1
        }
        //Move
        withAnimation{
            location.y += 30
        }
    }
    
    func takeDamage(dmg: CGFloat){
        health -= dmg
        if(health <= 0){
            isDead = true
        }
    }
}





//class Enemy: Identifiable {
//    var id = UUID()
//
//    var location: CGPoint
//    var previousLocation: CGPoint
//    var health: CGFloat
//
//    init(position: CGPoint, health : CGFloat){
//        self.location = position
//        self.previousLocation = .zero
//        self.health = health
//    }
//
//}
