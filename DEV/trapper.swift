//
//  trapper.swift
//  
//
//  Created by Toba Akinyemi on 3/24/22.
//

import Foundation

class trapper:Tower{
    override init() {
        trapper.attspd = 20
        trapper.range = 100
            //doesn't really do damage
            //maybe traps are a seperate class that are then placed onto world?
            
            super.init()
            
            name = "trapper"
        }
    
    func attack(enemy: Enemy){
        //doesn't really attack itself, needs to be able to place objects on world class
    }
    
    func readyToAttack(){
        canAttack = true
    }
}
