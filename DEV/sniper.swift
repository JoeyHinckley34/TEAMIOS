//
//  sniper.swift
//  
//
//  Created by Toba Akinyemi on 3/24/22.
//

import Foundation

class sniper: Tower{
    override init() {
        sniper.attspd = .5
        sniper.range = 1000
        sniper.dmg = 50
            
            super.init()
            
            name = "sniper"
        }
    
    func attack(enemy: Enemy){
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
