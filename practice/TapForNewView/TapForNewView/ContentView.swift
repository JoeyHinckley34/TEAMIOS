//
//  ContentView.swift
//  TapForNewView
//
//  Created by Joey Hinckley on 3/21/22.
//

import SwiftUI

struct NewView:Identifiable{
    var id = UUID()
    var location:CGPoint
}


struct Enemie:Identifiable{
    var id = UUID()
    var location:CGPoint
    var health:CGFloat
}



struct ContentView: View {
    
    @State private var enemiePosition = CGPoint(x: UIScreen.main.bounds.width/2, y:-10)
    
    @State var novelViews:[NewView] = []
    @State var enemieViews:[Enemie] = []
    @State var lastTapLocation:CGPoint = .zero

    let taplocation = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height-UIScreen.main.bounds.height/20)
    
    let start = CGPoint(x: UIScreen.main.bounds.width/2, y: .zero)
    let end = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    @GestureState private var dragState = DragState.inactive
    
    var body: some View {
        return Group{
            ZStack {
                Path { path in
                    path.move(to: start)
                    path.addLine(to: end)
                }
                .stroke(.green,lineWidth: 50)
                
                let NewEnemy = Enemy(position: enemiePosition, health: 10)
                EnemieView (enemy: NewEnemy)
                    .onReceive(self.timer){ _ in
                        self.moveEnemy()
                    }
                
                Text("New Tower Location \(self.lastTapLocation.debugDescription)")
                    .position(taplocation)
                //loop throughh every view and add a rectangle at its location
                ForEach(novelViews, id: \.id){ thisView in
                    Rectangle().frame(width: 20, height: 20)
                        .offset(self.getOffset(thisView.location))
                    //Loop through every other view and add path to it
                    ForEach(novelViews, id: \.id){ otherView in
                        Path{ path in
                            path.move(to: thisView.location)
                            path.addLine(to: otherView.location)
                        }
                        .stroke(.blue,lineWidth: 3)
                    }
                    
                    
                }
           
            }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(Color.white)
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .updating($dragState) { drag, state, transaction in
                    state = .dragging(translation: drag.translation)
                }
                .onEnded{value in
                    let startLoc = value.startLocation
                    let endLoc = value.location
                    
                    if (abs(startLoc.x - endLoc.x) <= 10 && abs(startLoc.y - endLoc.y) <= 10){
                        print("tap found")
                        self.novelViews.append(NewView(location: startLoc))
                    }
                }
                .onChanged{value in
                    self.lastTapLocation = value.startLocation
                    print("value changing")
                })
            .ignoresSafeArea()
        }
    
    }
    
    func moveEnemy(){
        if(self.enemiePosition.y > UIScreen.main.bounds.height+10){
            self.enemiePosition.y = -10
            //Lives -= 1
        }
        withAnimation{
            self.enemiePosition.y += 30
        }
    }
    
    func getOffset(_ originalOffset:CGPoint) -> CGSize{
        let xOffset = (-1 * (UIScreen.main.bounds.width/2) + originalOffset.x)
        let yOffset = (-1 * (UIScreen.main.bounds.height/2) + originalOffset.y)
        return CGSize(width: xOffset, height: yOffset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize{
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool{
        switch self{
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}
