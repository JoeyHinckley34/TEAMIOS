//
//  ContentView.swift
//  Movement
//
//  Created by Joey Hinckley on 3/2/22.
//

import SwiftUI


struct ContentView: View {
    @State private var enemiePosition = CGPoint(x: UIScreen.main.bounds.width/2, y:.zero-10)
    
    @State private var Lives = Double(20)
    
    let start = CGPoint(x: UIScreen.main.bounds.width/2, y: .zero)
    let end = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack{
                Path{ path in
                    path.move(to: start )
                    path.addLine(to: end)
                }
                .stroke(.green, lineWidth: 40)
                let NewNode = Node(position: enemiePosition, health: 10)
                NodeView (node: NewNode)
                    .onReceive(self.timer){ _ in
                        self.moveEnemy()
                    }
                //self.view.bringSubviewToFront(NodeView)
                
            }
            VStack(alignment: .center){
                Text("Enemie Position:")
                Text("x:\( Double(enemiePosition.x).stringWithoutTrailingZeros) y: \( Double(enemiePosition.y).stringWithoutTrailingZeros)")
                Text("Lives: \(Lives.stringWithoutTrailingZeros)")
            }
            .frame(width: geo.size.width, height: geo.size.width)
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.blue)
    }
    
    func moveEnemy(){
        if(self.enemiePosition.y > UIScreen.main.bounds.height+10){
            self.enemiePosition.y = -10
            Lives -= 1
        }
        withAnimation{
            self.enemiePosition.y += 30
        }
    }
}

extension Double {
    var stringWithoutTrailingZeros: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Previews_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
