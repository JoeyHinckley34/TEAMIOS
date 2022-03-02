//
//  Enemies.swift
//  DotsAndBoxes
//
//  Created by Joey Hinckley on 3/2/22.
//

import Foundation
import SwiftUI

class Enemies: ObservableObject {
    
    @Published var nodes: [Node] = []
    
    @Published var isRunning: Bool = false
    @Published var updater: Bool = false

    var timer: Timer?
    
    func update() {
        for node in nodes {
            let prevPos = node.position
            node.position += node.position - node.previousPosition
            node.position += CGPoint(x: 0, y: 0.196)
            node.previousPosition = prevPos
        }

    }
    
    func toggleSimulation() {
        if timer?.isValid == true {
            timer?.invalidate()
            isRunning = false
        } else {
            isRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { timer in
                self.updater.toggle()
                self.update()
                }
            )
        }
    }
    
    
    func reset() {
        if isRunning {
            toggleSimulation()
        }
    }
}
            
            
            
extension Strideable where Stride: SignedInteger {
    func clamped(to limits: CountableClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}



struct Previews_Enemies_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
