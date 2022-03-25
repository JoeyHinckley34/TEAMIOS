class Enemy {
    //REPRESENTATION:
    var xPos: Int
    var yPos: Int
    var hp: Int
    var isDead: Bool

    //Overriden default reps
    var speed: Int  { get { return 3 } }
    var hpMax: Int  { get { return 100 } }
    var ID: Int     { get { return 0 } }

    init(){
        init(x: 0, y: 0)
    }

    init(x: Int, y: Int){
        xPos = x
        yPos = y
        isDead = false
        hp = hpMax
    }

    //HOW DOES PATH WORK????
    func advance(path: /*help*/){
        path[]
    }

    func getReward() -> Int { 
        if(isDead)
            return 100
        return 0
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

/*
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
*/
