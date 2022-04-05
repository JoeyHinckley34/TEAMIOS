//
//  JohnsContentView.swift
//  TapForNewView
//
//  Created by john cohen on 3/29/22.
//


 import SwiftUI
 import SpriteKit

 struct NewView:Identifiable{
     var id = UUID()
     var location:CGPoint
     var enemiesInRange:[Enemy] = []
 }

 //struct Enemy:Identifiable{
 //    var id = UUID()
 //    var location:CGPoint
 //    var health:CGFloat
 //}

 struct ContentView: View {
     
     //@State private var enemiePosition = CGPoint(x: UIScreen.main.bounds.width/2, y:-10)
     
     @State var novelViews:[NewView] = []
     @State var enemyViews:[Enemy] = []
     @State var lastTapLocation:CGPoint = .zero

     let taplocation = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height-UIScreen.main.bounds.height/20)
     let damagelocation = CGPoint(x: UIScreen.main.bounds.width/5, y: UIScreen.main.bounds.height-(7*UIScreen.main.bounds.height/8))
     
     let start = CGPoint(x: UIScreen.main.bounds.width/2, y: .zero)
     let end = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)
     
     let timerPT = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
     
     let timerT = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
     
     @GestureState private var dragState = DragState.inactive
         
     @State private var damage:Int = 0
     
     var body: some View {
         return Group{
             ZStack {
                 Path { path in
                     path.move(to: start)
                     path.addLine(to: end)
                 }
                 .stroke(.green,lineWidth: 50)
                 
                 generateEnemies()
                 
                 Text("New Tower Location \(self.lastTapLocation.debugDescription)")
                     .position(taplocation)
                 
                 Text("Damage \(self.damage)")
                     .position(damagelocation)
                 
                 //self.damage = 0
                 //loop through every view and add a rectangle at its location
                 ForEach(novelViews, id: \.id){ thisView in
                         //editDamage(thisView.location, enemiePosition)
                     //Tower itself
                     Rectangle().frame(width: 20, height: 20)
                         .offset(self.getOffset(thisView.location))
                     //Tower Range
                     //Loops through all enemies on board to compute which enemies are in range of the current Tower
                     
                     ForEach(enemyViews, id: \.id){ currentEnemy in
                         //if currentEnemy in range, add to towers enemiesInRange array
                         if(abs(currentEnemy.location.y - thisView.location.y) < 100 && abs(currentEnemy.location.x - thisView.location.x) < 100){
                             thisView.enemiesInRange.append(currentEnemy)
                         }else{ //else if not in range, assure currentEnemy is not in enemiesInRange array
                             let updatedInRange = thisView.enemiesInRange.filter { $0.id != currentEnemy.id }
                             thisView.enemiesInRange = updatedInRange
                         }
                     }
                         //Change border if enemies are detected
                     Rectangle()
                         .strokeBorder( !(thisView.enemiesInRange.isEmpty()) ? Color.red : Color.black, lineWidth: 2)
                         
                         .frame(width: 200, height: 200)
                         .offset(self.getOffset(thisView.location))

                         //Deal damage to enemies in range
                         ForEach(thisView.enemiesInRange, id: \.id){ en in {
                             en.takeDamage(dmg: 1)
                         }
 //
 //                    if (abs(enemiePosition.y - thisView.location.y) < 100 && abs(enemiePosition.x - thisView.location.x) < 100 ){
 //                        self.damage += 1
 //                    }
 //
                     
                     //Loop through every other view and add path to it
 //                    ForEach(novelViews, id: \.id) { en in
 //                        //print(en.location)
 //                        Path{ path in
 //                            path.move(to: thisView.location)
 //                            path.addLine(to: en.location)
 //                        }
 //                        .stroke(.red,lineWidth: 3)
 //                    }
 //
                 }
            
             }
                 .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                 .background(Color.blue)
             .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                 .updating($dragState) { drag, state, transaction in
                     state = .dragging(translation: drag.translation)
                 }
                 .onEnded{value in
                     let startLoc = value.startLocation
                     let endLoc = value.location
                     
                     if (abs(startLoc.x - endLoc.x) <= 10 && abs(startLoc.y - endLoc.y) <= 10){
                         print("tap found")
                         //Ensure not on path
                         if (startLoc.x < 125 || startLoc.x > 195){
                             self.novelViews.append(NewView(location: startLoc))
                         }
                         
                         
                     }
                 }
                 .onChanged{value in
                     self.lastTapLocation = value.startLocation
                     print("value changing")
                 })
             .ignoresSafeArea()
         }
     
     }
     
 //    func editDamage(_ tower:CGPoint, _ enemy:CGPoint) {
 //        if (abs(enemy.y - tower.y) < 100 && abs(enemy.x - tower.x) < 100){
 //            self.damage += 1
 //        }
 //    }
 //
 /*    func moveEnemy(){
         //off screen
         if(self.enemiePosition.y > UIScreen.main.bounds.height+10){
             self.enemiePosition.y = -10
             //Lives -= 1
         }
         withAnimation{
             self.enemiePosition.y += 30
         }
     }*/
     
     func updateEnemy(currentEnemy: Enemy){
         if(currentEnemy.isDead){
             enemyViews = enemyViews.filter(){$0.id != currentEnemy.id} //Needs fixing, maybe base find off of id?
         }else{
             currentEnemy.move()
         }
     }
     
     //Loop for spawning multiple enemies
     func generateEnemies(){
         //Add timer loop??
         spawnEnemy(yOffset: 0)
         spawnEnemy(yOffset: 10)
         spawnEnemy(yOffset: 40)
     }
     
     //Spawns a single Enemy, appends to enemyViews array
     func spawnEnemy(yOffset: CGFloat){
         enemyViews.append(Enemy(position: CGPoint(x: start.x, y: start.y-yOffset), health: 10))
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


