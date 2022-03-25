class walker: Enemy {
    //standard speed, health
    #define MAX_HEALTH 100
    #define SPEED 3
    #define ID 0
    #define REWARD 100

    override init() { 
        speed = SPEED
        hpMax = MAX_HEALTH
        id = ID
        reward = REWARD
        super.init()
     }

}
