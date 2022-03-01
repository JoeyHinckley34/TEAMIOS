//
//  Pixel.swift
//  DotsAndBoxes
//
//  Created by Joey Hinckley on 2/28/22.
//

import SwiftUI

struct Pixel: View {
    let size: CGFloat
    let color: Color
    
    
    var body: some View {
        Rectangle()
            .frame(width: size, height: size)
            .foregroundColor(color)
    }
    
    
}

