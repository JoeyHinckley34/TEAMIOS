//
//  Tower.swift
//  TapForNewView
//
//  Created by john cohen on 4/7/22.
//

import SwiftUI
import Foundation

//Area of effect (AOE- attacks all in an area at once)
class Tower: Identifiable{
    var towerStyle: Int = 0
    var id = UUID()
    var damage: CGFloat = 1
    var shootTick: CGFloat = 2
    var currentTick: CGFloat = 0
    var cost: Double = 50
    var color: Color = Color(CGColor(red: 0.96, green: 0.23, blue: 0.43, alpha: 1))
    var range: CGFloat = 100
    
    var location:CGPoint
    var enemiesInRange:[EnemieView] = []
    
    
    init(location: CGPoint){
        self.location = location
    }
    
    //Finds enemies in range of this tower and updates enemiesInRange array
    func detectEnemies(enemyArray: [EnemieView]){
        for en in enemyArray {
            //if in range, add if not already where
            if(!en.enemy.isDead && distance(from: en.enemy.location, to: location) < range){
                if(!enemiesInRange.contains(where: { $0.id == en.id })){
                    enemiesInRange.append(en)
                }
            }else{ //else if not in range, assure currentEnemy is not in enemiesInRange array
                let updatedInRange = enemiesInRange.filter { $0.id != en.id }
                enemiesInRange = updatedInRange
            }
        }
        //print("\(enemiesInRange.count)")
    }
    
    //Deals damages to all enemies in range
    //When can shoot, shoots all enemies in range at once (AOE)
    func attack() -> Double {
        if(!canAttack())    {  return 0  }
        
        var rewardSum:Double = 0
        for en in enemiesInRange {
            if(!en.enemy.isDead){
                en.enemy.takeDamage(dmg: damage)
                currentTick = 0
                if(en.enemy.isDead){
                    rewardSum += en.enemy.reward
                }
            }
        }
        return rewardSum
    }
    
    func canAttack() -> Bool {
        if(currentTick >= shootTick){
            return true
        }
        currentTick += 1
        return false
    }
}

//AOE like base class with more damage and higher recharge
class FlameThrower: Tower{
    let TYPE: Int = 1
    let DAMAGE: CGFloat = 3
    let FireTickRate: CGFloat = 4
    let FlameCost: Double = 100
    let RANGE: CGFloat = 150
    
    override init(location: CGPoint) {
        super.init(location: location)
        super.towerStyle = TYPE
        super.damage = DAMAGE
        super.shootTick = FireTickRate
        super.cost = FlameCost
        super.color = Color(CGColor(red: 0, green: 0.23, blue: 0.43, alpha: 1))
        super.range = RANGE
     }
    
}

class Sniper: Tower {
    let TYPE: Int = 2
    let DAMAGE: CGFloat = 100
    let FireTickRate: CGFloat = 10
    let SniperCost: Double = 100
    let RANGE: CGFloat = 200
    
    override init(location: CGPoint) {
        super.init(location: location)
        super.towerStyle = TYPE
        super.damage = DAMAGE
        super.shootTick = FireTickRate
        super.cost = SniperCost
        super.color = Color(CGColor(red: 0.96, green: 1, blue: 0.43, alpha: 1))
        super.range = RANGE
     }
    
    override func attack() -> Double {
        if(!canAttack())    {  return 0  }
        
        var rewardSum:Double = 0
        if let en = enemiesInRange.first {
            en.enemy.takeDamage(dmg: damage)
            currentTick = 0
            if(en.enemy.isDead){
                rewardSum = en.enemy.reward
            }
        }
        return rewardSum
    }
}
