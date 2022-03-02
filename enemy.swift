class Enemy {
    //DEFINITIONS:
    #define TYPE1_HEALTH 100
    #define TYPE2_HEALTH 150
    #define TYPE3_HEALTH 200
    #define TYPE4_HEALTH 300
    #define DEFAULT_HEALTH 100

    #define TYPE1_SPEED 1
    #define TYPE2_SPEED 2
    #define TYPE3_SPEED 3
    #define TYPE4_SPEED 5
    #define DEFAULT_SPEED 1
    /**/

    //REPRESENTATION:
    var xPos: Int
    var yPos: Int
    var type: Int
    var hpMax: Int
    var hp: Int
    var speed: Int
    var isDead: Bool
    //var isFlying: Bool //air, ground
    //Color?
    /**/

    init(x: Int, y: Int, type: Int){
        isDead = false
        xPos = x
        yPos = y
        self.type = type
        setFinalValues(type)
        hp = hpMax
    }

    //HOW DOES PATH WORK????
    func advance(path: /*help*/){
        
    }

    //Determines hpMax, speed, color, ____, based on type
    func setFinalValues(type: Int){
        switch type {
        case 1:
            this.hpMax = TYPE1_HEALTH
            this.speed = TYPE1_SPEED
        case 2:
            this.hpMax = TYPE2_HEALTH
            this.speed = TYPE2_SPEED
        case 3:
            this.hpMax = TYPE3_HEALTH
            this.speed = TYPE3_SPEED
        case 4:
            this.hpMax = TYPE4_HEALTH
            this.speed = TYPE4_SPEED
        /*case MORE:
            this.hpMax = MORE
            this.speed = MORE*/
        default:
            this.hpMax = DEFAULT_HEALTH
            this.speed = DEFAULT_SPEED
        }
    }

    func recieveDamage(dmg: Int){
        if(hp <= dmg){
            isDead = true;
            hp = 0
        }else{
            hp -= dmg
        }
    }
}