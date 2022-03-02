//
//  NodeView.swift
//  DotsAndBoxes
//
//  Created by Joey Hinckley on 3/1/22.
//
import Foundation
import SwiftUI

struct NodeView: View {
    var node: Node
    var body: some View {
        Circle()
            .frame(width: 15, height: 15)
            .foregroundColor(.red)
            .position(node.position)
    }
}
