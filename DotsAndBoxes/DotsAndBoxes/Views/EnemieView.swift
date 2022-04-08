//
//  EnemieView.swift
//  TapForNewView
//
//  Created by Joey Hinckley on 3/23/22.
//
import Foundation
import SwiftUI

//Enemy View Struct, required to display tower classes
struct EnemieView: Identifiable, View{
    var id = UUID()
    var enemy: Enemy
    //*
     var body: some View {
        ZStack{
            Rectangle()
                .frame(width: enemy.health*3, height: 10)
                .foregroundColor(.green)
                .position( CGPoint( x:enemy.location.x,y:enemy.location.y - 15))
            Circle()
                .frame(width: 15, height: 15)
                .foregroundColor(Color(CGColor(red: 0.96, green: 0.23, blue: 0.43, alpha: 1)))
                .position(enemy.location)
        }
        
        
    }//*/
}
