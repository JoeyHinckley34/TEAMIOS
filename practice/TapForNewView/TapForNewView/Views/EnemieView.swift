//
//  EnemieView.swift
//  TapForNewView
//
//  Created by Joey Hinckley on 3/23/22.
//
import Foundation
import SwiftUI

struct NodeView: View{
    var enemy: Enemy
    var body: some View {
        Circle()
            .frame(width: 15, height: 15)
            .foregroundColor(.red)
            .position(enemy.position)
        
    }
}
