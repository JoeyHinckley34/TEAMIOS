class sprinter: Enemy {
    //alternating quite high - slightly below standard speed, slightly low health
    #define MAX_HEALTH 75
    #define SPEED_1 5
    #define SPEED_2 2
    #define ID 2
    #define REWARD 100
    var isFast: Bool

    override init() {
        isFast = true

        speed = SPEED
        hpMax = MAX_HEALTH
        id = ID
        reward = REWARD
        super.init()
     }
}

    func getSpeed() -> Int {
        isFast = !(isFast)
        if(isFast){
            return SPEED_1
        }
        return SPEED_2
    }

    //very much not done
    override func advance(var movePath: [CGPoint]){
        path = movePath
        if movePath.count > 0{
            let nextLocation = movePath.removeFirst()
            
            let distance = distanceBetweenPoints(position, second: nextLocation)
            let duration = durationToMove(distance, distancePerSecond: getSpeed() /*ms*/)
            let moveAction = SKAction.sequence([SKAction.moveTo(nextLocation, duration: duration), SKAction.runBlock({self.moveAlongPath(movePath)})])
            runAction(moveAction, withKey: GlobalConstants.keyMove)
           
        }
        else{
            arrived = true
            removeFromParent()
        }
    }
}
