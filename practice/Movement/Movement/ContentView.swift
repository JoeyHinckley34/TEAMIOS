//
//  ContentView.swift
//  Movement
//
//  Created by Joey Hinckley on 3/2/22.
//

import SwiftUI


struct ContentView: View {
    @State private var enemiePosition = CGPoint(x: 200, y:-10)
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        
        GeometryReader {   geo in
            ZStack{
                
                let NewNode = Node(position: enemiePosition, health: 10)
                NodeView (node: NewNode)
                    .onReceive(self.timer){ _ in
                        self.moveEnemy()
                    }
                
                
            }
            HStack(alignment: .bottom){
                Text("\(enemiePosition.x) \(enemiePosition.y)")
            }
            .frame(width: geo.size.width, height: geo.size.width)
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.blue)
        
        
//        .gesture(
//            DragGesture(minimumDistance: 0)
//                .onEnded{ drag in
//                    let newNode = Node(position: drag.location, health: 10)
//                    NodeView (node: newNode)
//                }
//        )
        
    }
    
    
    
    
    func moveEnemy(){
        if(self.enemiePosition.y > 1100){
            self.enemiePosition.y = -10
        }
        withAnimation{
            self.enemiePosition.y += 30
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
