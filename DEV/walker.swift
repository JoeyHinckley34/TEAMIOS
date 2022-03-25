class walker: Enemy {
    //standard speed, health
    #define MAX_HEALTH 100
    #define SPEED 3
    #define ID 0
    #define REWARD 100

    override var speed: Int  { get { return SPEED } }
    override var hpMax: Int  { get { return MAX_HEALTH } }
    override var ID: Int     { get { return ID } }

    override init() { init(x: 0, y: 0) }

    override init(x: Int, y: Int){
        super.init(x: x, y: y)
    }

    override func getReward() -> Int { 
        if(isDead)
            return REWARD
        return 0
    }
}