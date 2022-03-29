//
//  ContentView.swift
//  PolymorphicViews
//
//  Created by Joey Hinckley on 3/25/22.
//

import SwiftUI

struct EnemyView: View {
    var enemy: EnemyBase
    var body: some View{
        Circle()
            .frame(width: 15, height: 15)
            .foregroundColor(.red)
            .position(enemy.location)
    }
}

class EnemyBase: Identifiable {
    var id = UUID()
    
    var location: CGPoint
    var previousLocation: CGPoint
    var health: CGFloat
    
    init(position: CGPoint, health : CGFloat){
        self.location = position
        self.previousLocation = .zero
        self.health = health
    }
    
    func showView() -> AnyView {
        AnyView(EnemyView(enemy: self))
    }
    
}

struct View1: View {
    var body: some View {
        Text("View1")
    }
}

struct View2: View {
    var body: some View {
        Text("View2")
    }
}

class ViewBase: Identifiable {
    func showView() -> AnyView {
        AnyView(EmptyView())
    }
}


class AnyView1: ViewBase {
    override func showView() -> AnyView {
        AnyView(View1())
    }
}

class AnyView2: ViewBase {
    override func showView() -> AnyView {
        AnyView(View2())
    }
}

class AnyEnemyView: ViewBase {
    override func showView() -> AnyView {
        AnyView(EnemyView(enemy: EnemyBase(position: CGPoint(x: UIScreen.main.bounds.width/2, y: 100), health: 10)))
    }
}




class AnyEnemy: EnemyBase {
    override func showView() -> AnyView {
        AnyView(EnemyView(enemy: EnemyBase(position: CGPoint(x: UIScreen.main.bounds.width/2, y: .zero-10), health: 10)) )
    }
}





struct ContentView: View {
    
    
    let timerPT = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    let views: [ViewBase] = [
        //AnyView1(),
        //AnyView2(),
        AnyEnemyView()
            
    ]
    
    let enemys: [EnemyBase] = [
        AnyEnemy(position: CGPoint(x: UIScreen.main.bounds.width/2, y:100), health: 10)
    ]
    

    var body: some View {
        return Group{
            ZStack{
                ForEach(self.enemys) { viewIn in
                    viewIn.showView()
                        .onReceive(self.timerPT){ _ in
                            self.moveEnemy(view: viewIn)
                        }
//
                    
                    
                }
                
//                List(self.views) { view in
//                    view.showView()
//                }
            }
            
        }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            .background(Color.white)
    }
    
    func moveEnemy(view: EnemyBase ){
        if(view.location.y > UIScreen.main.bounds.height+10){
            view.location.y = -10
            //Lives -= 1
        }
        withAnimation{
            view.location.y += 30
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
