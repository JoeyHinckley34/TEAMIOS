//
//  gunner.swift
//  
//
//  Created by Toba Akinyemi on 3/24/22.
//

import Foundation

class gunner: Tower{
    override init() {
        gunner.attspd = 10
        gunner.range = 100
        gunner.dmg = 1
            
            super.init()
            
            name = "gunner"
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
