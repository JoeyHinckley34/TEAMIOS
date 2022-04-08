class runner: Enemy {
    //high speed, low health
    #define MAX_HEALTH 50
    #define SPEED 4
    #define ID 3
    #define REWARD 100
    
    override init() { 
        speed = SPEED
        hpMax = MAX_HEALTH
        id = ID
        reward = REWARD
        super.init()
     }
}
