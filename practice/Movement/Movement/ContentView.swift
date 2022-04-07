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
    
    @State private var Enemies:[NodeView] = []
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack{
                Path{ path in
                    path.move(to: start )
                    path.addLine(to: end)
                }
                .stroke(.green, lineWidth: 40)
                
                var NewNode = Node()
                var ememy = NodeView (node: NewNode)
                    .onReceive(self.timer){ e in
                        NewNode.moveSelf()
                        self.moveEnemy(node: NewNode)
                       
                    }
               
                //self.view.bringSubviewToFront(NodeView)
                
            }
            VStack(alignment: .center){
                Text("Enemy Position:")
                Text("x:\( Double(enemiePosition.x).stringWithoutTrailingZeros) y: \( Double(enemiePosition.y).stringWithoutTrailingZeros)")
                Text("Lives: \(Lives.stringWithoutTrailingZeros)")
            }
            .frame(width: geo.size.width, height: geo.size.width)
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.blue)
    }
    
    func moveEnemy(node: Node){
        if(node.position.y > UIScreen.main.bounds.height+10){
            node.position.y = .zero-10
            Lives -= 1
        }
        node.position.y += 30
        withAnimation{
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
