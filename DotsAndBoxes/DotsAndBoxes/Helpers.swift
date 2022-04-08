//
//  Helpers.swift
//  TapForNewView
//
//  Created by Olin Ryan on 4/1/22.
//

import Foundation
import SwiftUI

//Calcutates and returns sqrt distance
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
    
    eV.append(spawnRunner(yOffset: 0))
    eV.append(spawnSprinter(yOffset: -50))
    eV.append(spawnWalker(yOffset: -100))
    eV.append(spawnTank(yOffset: -150))
    
    return eV
}

//Initializes a single Enemy
//Returns EnemieView to be spawned and appended to enemyViews array in appendNewWave()
func spawnEnemy(yOffset: CGFloat) -> EnemieView{
    let NewEnemy = Enemy(position: CGPoint(x:UIScreen.main.bounds.width/2, y: .zero-yOffset))
    let enemyView = EnemieView (enemy: NewEnemy)
    return enemyView
}
func spawnWalker(yOffset: CGFloat) -> EnemieView{
    let NewEnemy = Walker(position: CGPoint(x:UIScreen.main.bounds.width/2, y: .zero-yOffset))
    let enemyView = EnemieView (enemy: NewEnemy)
    return enemyView
}
func spawnTank(yOffset: CGFloat) -> EnemieView{
    let NewEnemy = Tank(position: CGPoint(x:UIScreen.main.bounds.width/2, y: .zero-yOffset))
    let enemyView = EnemieView (enemy: NewEnemy)
    return enemyView
}
func spawnRunner(yOffset: CGFloat) -> EnemieView{
    let NewEnemy = Runner(position: CGPoint(x:UIScreen.main.bounds.width/2, y: .zero-yOffset))
    let enemyView = EnemieView (enemy: NewEnemy)
    return enemyView
}
func spawnSprinter(yOffset: CGFloat) -> EnemieView{
    let NewEnemy = Sprinter(position: CGPoint(x:UIScreen.main.bounds.width/2, y: .zero-yOffset))
    let enemyView = EnemieView (enemy: NewEnemy)
    return enemyView
}


//Updates All Enemy in positions
//Returns number of enemies that cross location to subtract from remaining Lives
func moveEnemies(enemyViewsArray: [EnemieView]) -> Double{
    var lostLives:Double = 0
    for currentEnemy in enemyViewsArray {
        if(!currentEnemy.enemy.isDead){
            lostLives += currentEnemy.enemy.move()
        }
    }
    return lostLives
}
