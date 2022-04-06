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
    var reward: Double = 30
    
    init(position: CGPoint, health : CGFloat){
        self.location = position
        self.previousLocation = .zero
        self.health = health
        isDead = false
    }
    
    func move(){
        //off screen
        if(location.y > UIScreen.main.bounds.height-30){
            isDead = true
            location.y = 30
            //print("dead")
        }else{
            //Move
            withAnimation{
                location.y += 5
            }
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
