class sprinter: Enemy {
    //alternating quite high - slightly below standard speed, slightly low health
    #define MAX_HEALTH 75
    #define SPEED_1 5
    #define SPEED_2 2
    #define ID 2
    #define REWARD 100
    
    override var speed: Int  { get { return SPEED } }
    override var hpMax: Int  { get { return MAX_HEALTH } }
    override var ID: Int     { get { return ID } }
    
    var isFast: Bool

    override init() { init(x: 0, y: 0) }

    override init(x: Int, y: Int){
        isFast = false:
        super.init(x: x, y: y, speed: SPEED_1, hpMax: MAX_HEALTH)
    }

    override func getReward() -> Int { 
        if(isDead)
            return REWARD
        return 0
    }

    func getSpeed() -> Int {
        isFast = !(isFast)
        if(isFast){
            return SPEED_1
        }
        return SPEED_2
    }

    override func advance(){
        
    }
}