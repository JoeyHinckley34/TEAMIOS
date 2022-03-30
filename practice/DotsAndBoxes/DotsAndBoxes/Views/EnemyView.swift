//
//  EnemyView.swift
//  DotsAndBoxes
//
//  Created by administrator on 3/29/22.
//

import SwiftUI

struct EnemyView: View {
    var enemy: Enemy
    var body: some View {
        Circle()
            .frame(width: 15, height: 15)
            .foregroundColor(.red)
            .position(enemy.position)
    }
}
