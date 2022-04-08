//
//  Tower.swift
//  TapForNewView
//
//  Created by john cohen on 4/7/22.
//

import SwiftUI
import Foundation

class Tower: Identifiable{
    var id = UUID()
    var location:CGPoint
    var enemiesInRange:[EnemieView] = []
    
    init(location: CGPoint){
        self.location = location
    }
    
    func detectEnemies(enemyArray: [EnemieView]){
        for en in enemyArray {
            //if in range, add if not already where
            if(abs(en.enemy.location.y - location.y) < 100 && abs(en.enemy.location.x - location.x) < 100){
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
    
    func attack() -> Double {
        var rewardSum:Double = 0
        for en in enemiesInRange {
            if(!en.enemy.isDead){
                en.enemy.takeDamage(dmg: 1)
                if(en.enemy.isDead){
                    rewardSum += en.enemy.reward
                }
            }
        }
        return rewardSum
    }
}
