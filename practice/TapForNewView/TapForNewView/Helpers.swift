//
//  Helpers.swift
//  TapForNewView
//
//  Created by Olin Ryan on 4/1/22.
//

import Foundation
import SwiftUI

func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
    let xDist = a.x - b.x
    let YDist = a.y - b.y
    return CGFloat(sqrt(xDist * xDist + YDist * YDist))
}


//Adds more enemies to current array
//Returns appended enemy array
//Ex: "enemyViews = appendNewWave(initialEV: enemyViews)"
func appendNewWave(initialEV: [EnemieView]) -> [EnemieView]{
    
    var eV:[EnemieView] = initialEV

    eV.append(spawnEnemy(yOffset: -50))
    eV.append(spawnEnemy(yOffset: -100))
    eV.append(spawnEnemy(yOffset: -150))
    
    return eV
}

//Spawns a single Enemy, appends to enemyViews array
func spawnEnemy(yOffset: CGFloat) -> EnemieView{
    let NewEnemy = Enemy(position: CGPoint(x:UIScreen.main.bounds.width/2, y: .zero-yOffset), health: 10)
    let enemyView = EnemieView (enemy: NewEnemy)
    return enemyView
    //enemyViews.append(Enemy(position: CGPoint(x: start.x, y: start.y-yOffset), health: 10))
}


//Updates Enemy in position and checks life to be filtered if dead
//Returns updated/filtered enemy array
//Ex of enemies being updated: "enemyViews = updateEnemies(enemyViewsArray: enemyViews)"
func moveEnemies(enemyViewsArray: [EnemieView]) {
    for currentEnemy in enemyViewsArray {
        if(!currentEnemy.enemy.isDead){
            currentEnemy.enemy.move()
        }
    }
}
