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


//Loop for spawning multiple enemies
func generateEnemies() -> [EnemieView]{
    
    var eV:[EnemieView] = []

    eV.append(spawnEnemy(yOffset: -100))
    eV.append(spawnEnemy(yOffset: -10))
    eV.append(spawnEnemy(yOffset: -40))
    return eV
}

//Spawns a single Enemy, appends to enemyViews array
func spawnEnemy(yOffset: CGFloat) -> EnemieView{
    let NewEnemy = Enemy(position: CGPoint(x:UIScreen.main.bounds.width/2, y: .zero-yOffset), health: 10)
    let enemyView = EnemieView (enemy: NewEnemy)
    return enemyView
    //enemyViews.append(Enemy(position: CGPoint(x: start.x, y: start.y-yOffset), health: 10))
}
