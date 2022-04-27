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
    var type: Int
    var location: CGPoint
    var health: CGFloat
    var reward: Double
    var speed: Double
    var color: Color = Color(CGColor(red: 0.96, green: 0.23, blue: 0.43, alpha: 1))
    var isDead: Bool

    let healthMultiplier: CGFloat = 1.5
    let speedMultiplier: Double = 4

    init(position: CGPoint) {
        type = 0
        location = position
        health = 10
        speed = 5
        reward = 30
        isDead = false
    }

    init() {
        type = 0
        location = CGPoint(x: UIScreen.main.bounds.width/2, y: -10)
        health = 10
        speed = 5
        reward = 30
        isDead = false
    }

    // Updates position
    // Returns if reaches player
    func move() -> Double {
        // off screen
        if location.y > UIScreen.main.bounds.height-30 {
            isDead = true
            location.y = 30
            return 1
        }
        // Else Move
        withAnimation {
            location.y += speed
        }
        return 0
    }

    // Recieve damage, updates health, determines if dead
    func takeDamage(dmg: CGFloat) {
        health -= dmg
        if health <= 0 {
            isDead = true
        }
    }
}

class Walker: Enemy {
    // standard speed, health
    let TYPE: Int = 0
    let MAX_HEALTH: CGFloat = 25
    let REWARD: Double = 30
    let SPEED: Double = 3

    override init(position: CGPoint) {
        super.init()
        super.type = TYPE
        super.location = position
        super.health = MAX_HEALTH * super.healthMultiplier
        super.reward = REWARD
        super.speed = 3 * super.speedMultiplier
        super.color = Color(CGColor(red: 0.96, green: 0.23, blue: 0.43, alpha: 1))
     }

}

class Tank: Enemy {
    // slow, high health
    let TYPE: Int = 1
    let MAX_HEALTH: CGFloat = 50
    let REWARD: Double = 50
    let SPEED: Double = 2

    override init(position: CGPoint) {
        super.init()
        super.type = TYPE
        super.location = position
        super.health = MAX_HEALTH * super.healthMultiplier
        super.reward = REWARD
        super.speed = 3 * super.speedMultiplier
        super.color = Color(CGColor(red: 0, green: 0.23, blue: 0.43, alpha: 1))
     }
}

class Runner: Enemy {
    // high speed, low health
    let TYPE: Int = 2
    let MAX_HEALTH: CGFloat = 15
    let REWARD: Double = 50
    let SPEED: Double = 5

    override init(position: CGPoint) {
        super.init()
        super.type = TYPE
        super.location = position
        super.health = MAX_HEALTH * super.healthMultiplier
        super.reward = REWARD
        super.speed = 3 * super.speedMultiplier
        super.color = Color(CGColor(red: 0.96, green: 1, blue: 0.43, alpha: 1))
     }
}

 class Sprinter: Enemy {
     // alternating quite high - slightly below standard speed, slightly low health
     let TYPE: Int = 2
     let MAX_HEALTH: CGFloat = 35
     let REWARD: Double = 50
     let SPEED_1: Double = 8
     let SPEED_2: Double = 2
     var isFastCount: Int
     let fastTickLimit: Int = 30
     var isSlowCount: Int
     let slowTickLimit: Int = 15

     override init(position: CGPoint) {
         isFastCount = 0
         isSlowCount = 0
         super.init()
         super.type = TYPE
         super.location = position
         super.health = MAX_HEALTH * super.healthMultiplier
         super.reward = REWARD
         super.speed = 3 * super.speedMultiplier
         super.color = Color(CGColor(red: 0.60, green: 0.93, blue: 0.53, alpha: 1))
      }

     // Determines current speed
     // Returns calculated speed
     func getSpeed() -> Double {
         if isFastCount < fastTickLimit {
             isFastCount += 1
             return SPEED_1
         } else {
             if isSlowCount < slowTickLimit {
                 isSlowCount += 1
                 return SPEED_2
             } else {
                 isFastCount = 0
                 isSlowCount = 0
             }
         }
         isFastCount += 1
         return SPEED_1
     }

     // Calls getSpeed, updates speed, and moves with updated speed
     // Returns if enemy reaches player: [1] for true, [0] for false
     override func move() -> Double {
         super.speed = getSpeed()
         return super.move()
     }
 }
