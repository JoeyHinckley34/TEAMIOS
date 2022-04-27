//
//  Helpers.swift
//  TapForNewView
//

import Foundation
import SwiftUI

var enemiesSpawned: CGFloat = 0

// Calcutates and returns sqrt distance
func distance(from: CGPoint, to: CGPoint) -> CGFloat {
    let xDist = from.x - to.x
    let YDist = from.y - to.y
    return CGFloat(sqrt(xDist * xDist + YDist * YDist))
}

// Adds more enemies to current array
// Returns appended enemy array
// Ex: "enemyViews = appendNewWave(initialEV: enemyViews)"
func appendNewWave(initialEV: [EnemieView]) -> [EnemieView] {

    var eV: [EnemieView] = initialEV

    eV.append(spawnRunner(yOffset: 0))
    eV.append(spawnSprinter(yOffset: 50))
    eV.append(spawnWalker(yOffset: 100))
    eV.append(spawnTank(yOffset: 150))

    return eV
}

func appendRandomAmount(initialEV: [EnemieView]) -> [EnemieView] {
    var eV: [EnemieView] = initialEV

    let rdm: Int = Int.random(in: 1..<4)
    var yOffset: CGFloat = 0
    for _ in 1...rdm {
        eV.append(spawnRandom(yOffset: yOffset))
        yOffset += CGFloat.random(in: 30..<60)
    }

    return eV
}

// Initializes a single Enemy, increases health for every enemy previously spawned
// Returns EnemieView to be spawned and appended to enemyViews array in appendNewWave()
func spawnEnemy(yOffset: CGFloat) -> EnemieView {
    let NewEnemy = Enemy(position: CGPoint(x: UIScreen.main.bounds.width/2, y: .zero-yOffset))
    NewEnemy.health += enemiesSpawned
    enemiesSpawned += 1
    let enemyView = EnemieView(enemy: NewEnemy)
    return enemyView
}
func spawnWalker(yOffset: CGFloat) -> EnemieView {
    let NewEnemy = Walker(position: CGPoint(x: UIScreen.main.bounds.width/2, y: .zero-yOffset))
    NewEnemy.health += enemiesSpawned
    enemiesSpawned += 1
    let enemyView = EnemieView(enemy: NewEnemy)
    return enemyView
}
func spawnTank(yOffset: CGFloat) -> EnemieView {
    let NewEnemy = Tank(position: CGPoint(x: UIScreen.main.bounds.width/2, y: .zero-yOffset))
    NewEnemy.health += enemiesSpawned
    enemiesSpawned += 1
    let enemyView = EnemieView(enemy: NewEnemy)
    return enemyView
}
func spawnRunner(yOffset: CGFloat) -> EnemieView {
    let NewEnemy = Runner(position: CGPoint(x: UIScreen.main.bounds.width/2, y: .zero-yOffset))
    NewEnemy.health += enemiesSpawned
    enemiesSpawned += 1
    let enemyView = EnemieView(enemy: NewEnemy)
    return enemyView
}
func spawnSprinter(yOffset: CGFloat) -> EnemieView {
    let NewEnemy = Sprinter(position: CGPoint(x: UIScreen.main.bounds.width/2, y: .zero-yOffset))
    NewEnemy.health += enemiesSpawned
    enemiesSpawned += 1
    let enemyView = EnemieView(enemy: NewEnemy)
    return enemyView
}
func spawnRandom(yOffset: CGFloat) -> EnemieView {
    let rdm: Int = Int.random(in: 1..<5)
    switch rdm {
    case 1:
        return spawnWalker(yOffset: yOffset)

    case 2:
       return spawnTank(yOffset: yOffset)

    case 3:
        return spawnRunner(yOffset: yOffset)

    case 4:
        return spawnSprinter(yOffset: yOffset)

    default:
        return spawnEnemy(yOffset: yOffset)
    }
}

// Updates All Enemy in positions
// Returns number of enemies that cross location to subtract from remaining Lives
func moveEnemies(enemyViewsArray: [EnemieView]) -> Double {
    var lostLives: Double = 0
    for currentEnemy in enemyViewsArray {
        if !currentEnemy.enemy.isDead {
            lostLives += currentEnemy.enemy.move()
        }
    }
    return lostLives
}
