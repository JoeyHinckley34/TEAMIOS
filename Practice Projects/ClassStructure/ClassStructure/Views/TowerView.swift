//
//  TowerView.swift
//  DotsAndBoxes
//
//  Created by administrator on 3/29/22.
//

import SwiftUI

struct TowerView: View {
    var tower: Tower
    var body: some View {
        Rectangle()
            .frame(width: 20, height: 20)
            .foregroundColor(.blue)
            .position(tower.position)
    }
}
