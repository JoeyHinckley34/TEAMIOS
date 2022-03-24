//
//  ContentView.swift
//  PathPractice
//
//  Created by Joey Hinckley on 3/24/22.
//

import SwiftUI

struct ContentView: View {
    
    let start = CGPoint(x: UIScreen.main.bounds.width/2, y: .zero)
    let end = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)
    
    var body: some View {
        ZStack{
            Path { path in
                path.move(to: start)
                path.addLine(to: end)
                
            }
            .stroke(.blue,lineWidth: 50)
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
