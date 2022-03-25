class runner: Enemy {
    //high speed, low health
    #define MAX_HEALTH 50
    #define SPEED 4
    #define ID 3
    #define REWARD 100
    
    override var speed: Int  { get { return SPEED } }
    override var hpMax: Int  { get { return MAX_HEALTH } }
    override var ID: Int     { get { return ID } }

    override init() { init(x: 0, y: 0) }

    override init(x: Int, y: Int){
        super.init(x: x, y: y, speed: SPEED, hpMax: MAX_HEALTH)
    }

    override func getReward() -> Int { 
        if(isDead)
            return REWARD
        return 0
    }
}