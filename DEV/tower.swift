class Tower: SKNode {
    var attspd: Double
    var range: Float
    var dmg: Double
    var canAttack: Bool = true
    var hasTarget: Bool = false
    
    //all towers attack differently so attack and projectile functions are made in the specific classes
}
