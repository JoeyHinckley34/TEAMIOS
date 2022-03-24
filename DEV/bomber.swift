//
//  bomber.swift
//  
//
//  Created by Toba Akinyemi on 3/24/22.
//

import Foundation

class bomber: Tower{
    override init() {
        bomber.attspd = 5
        bomber.range = 50
        bomber.dmg = 5
            
            super.init()
            
            name = "bomber"
        }
    
    func attack(enemy: Enemy){
        //needs to be able to do aoe damage (affect world class to do damage around a spot?)
        if canAttack{
            if !unit.isAlive() || distanceToNode(unit) > range{
                hasTarget = false
                return
            }
            let projectile = getProjectile()
            projectile.position = position
            self.parent?.addChild(projectile)
            projectile.followNode(enemy)
            
            canAttack = false
            
            let attackAction = SKAction.sequence([SKAction.waitForDuration(attspd), SKAction.runBlock({self.readyToAttack()})])
            
            runAction(attackAction)
        }
    }
    
    func readyToAttack(){
        canAttack = true
    }
    
    func getProjectile() -> Projectile{
        return Projectile()
    }
}
