//
//  EnemieView.swift
//  TapForNewView
//
//  Created by Joey Hinckley on 3/23/22.
//
import Foundation
import SwiftUI

struct EnemieView: View{
    var enemy: Enemy
    var body: some View {
        Circle()
            .frame(width: 15, height: 15)
            .foregroundColor(.red)
            .position(enemy.location)
        
    }
}
