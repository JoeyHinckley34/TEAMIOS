class tank: Enemy {
    //slow, high health
    #define MAX_HEALTH 250
    #define SPEED 1
    #define ID 1
    #define REWARD 100

    override init() { 
        speed = SPEED
        hpMax = MAX_HEALTH
        id = ID
        reward = REWARD
        super.init()
     }
}
