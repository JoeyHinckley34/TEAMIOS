

import Foundation
import SpriteKit

class Enemy: SKNode {
    //REPRESENTATION:
    var hp: Int
    var isAlive = true
    var arrived = false
    var path: [CGPoint] = []

    //Class Specific
    var speed: Int
    var hpMax: Int
    var id: Int
    var reward: Int

    override init(){
        hp = hpMax

        super.init()
    }

    //very much not done
    func advance(var movePath: [CGPoint]){
        path = movePath
        if movePath.count > 0{
            let nextLocation = movePath.removeFirst()
            
            let distance = distanceBetweenPoints(position, second: nextLocation)
            let duration = durationToMove(distance, distancePerSecond: ms)
            let moveAction = SKAction.sequence([SKAction.moveTo(nextLocation, duration: duration), SKAction.runBlock({self.moveAlongPath(movePath)})])
            runAction(moveAction, withKey: GlobalConstants.keyMove)
           
        }
        else{
            arrived = true
            removeFromParent()
        }
    }

    func getReward() -> Int { 
        if(!isAlive)
            return reward
        return 0
    }

    func recieveDamage(dmg: Int){
        if(hp <= dmg){
            isAlive = false;
            hp = 0
            removeFromParent()
        }else{
            hp -= dmg
        }
    }
}
