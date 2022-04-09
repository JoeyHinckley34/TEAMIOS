//
//  ContentView.swift
//  DotsAndBoxes
//
//  Created by Joey Hinckley on 3/21/22.
//
import SwiftUI

//Mutable Player Data
class Player: Identifiable {
    var Bank:Double
    var Lives:Double
    //var enemiesSpawned: CGFloat = 0
    var novelViews:[NewView] = []
    var enemyViews:[EnemieView] = appendNewWave(initialEV: [])
    init(bank: Double, lives: Double){
        Bank = bank
        Lives = lives
    }
}


//Main Display and Game Calculations
struct ContentView: View {
    
    @State private var updaterPos = CGPoint(x: UIScreen.main.bounds.width/2, y:-10)
    @State private var enemieHealth:CGFloat = 10
    
    @State private var damage:Int = 0
    
    //tower types
    var towers = ["Cannon","Blowie","Pins"]
    @State private var towerStyle = 0

    var LvlLives:Double = 5
    var LvlBank:Double = 200
    var player:Player = Player(bank: 200, lives: 5)
    
    //@State var novelViews:[NewView] = []
    //@State var enemyViews:[EnemieView] = appendNewWave(initialEV: [])
    @State var lastTapLocation:CGPoint = .zero

    var Width : CGFloat {
        get {
            return UIScreen.main.bounds.width
        }
    }
    
    private let Height:CGFloat = UIScreen.main.bounds.height

    //Player info Displays
    var damagelocation : CGPoint{
        get{
            return CGPoint(x: Width/5, y: Height-(1*Height/16))
        }
    }
    var healthlocation : CGPoint{
        get {
            return CGPoint(x: Width-Width/5, y: Height-(15*Height/16))
        }
    }
    var banklocation : CGPoint {
        get {
            return CGPoint(x: Width/5, y: Height-(15*Height/16))
        }
    }
    var ResetLocation : CGPoint {
        get {
            return CGPoint(x: Width-Width/5, y: Height-(1*Height/16))
        }
    }
    
    let start = CGPoint(x: UIScreen.main.bounds.width/2, y: .zero)
    let pt1 = CGPoint(x: 200, y: UIScreen.main.bounds.height/2)
    let end = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)   
    let timerPT = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    let timerT = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    @GestureState private var dragState = DragState.inactive
    
    let pathColor = CGColor(red: 1, green: 0.85, blue: 0.24, alpha: 1)
    let MenuColor = CGColor(red: 1, green: 0.89, blue: 0.74, alpha: 1)
    let towerColor = CGColor(red: 0.20, green: 0.24, blue: 51, alpha: 1)
    let backgroundColor = CGColor(red: 0.42, green: 0.80, blue: 0.47, alpha: 1)
    
    
    
    var body: some View {
        
        //Move enemies and subtract lives if get to player
        player.Lives -= moveEnemies(enemyViewsArray: player.enemyViews)

        if(player.Lives <= 0){
            resetLevel()
        }
        //towers find enemies and attack those in range
        for t in player.novelViews {
            t.tower.detectEnemies(enemyArray: player.enemyViews)
            player.Bank += t.tower.attack()
        }
    
        return Group{
            ZStack {
                //Menu Path
                Path { path in
                    path.move(to: CGPoint(x: 0, y: Height))
                    path.addLine(to: CGPoint(x: Width, y: Height))
                }
                    .stroke(Color(cgColor: MenuColor) ,lineWidth: Height/4)
                
               
                
                Button ("Reset: \(self.towers[self.towerStyle])"){
                    resetLevel()
                }
                    .padding()
                    .foregroundColor(.red)
                    .position(ResetLocation)
                
                Picker(selection: $towerStyle, label:  Text("")){
                    ForEach(0 ..< towers.count, id:\.self) { i in
                        Text(towers[i])
                    }
                }
                    .padding()
                    .pickerStyle(MenuPickerStyle())
                    .position(damagelocation)
    
                Path { path in
                    path.move(to: start)
//                    path.addLine(to: pt1)
                    path.addLine(to: end)
                }
                    .stroke(Color(cgColor: pathColor) ,lineWidth: 50)
                
                //DISPLAYING ENEMIES
                Group {
                    //This needs to be running to have the code run continuous, not stop when wait for tap gesture
                    let updater = Enemy(position: updaterPos) //the ONLY enemy
                    EnemieView (enemy: updater)
                        .onReceive(self.timerPT){ _ in
                            self.updateUpdater()
                        }
                    
                    ForEach(player.enemyViews, id: \.id) { thisEnemy in
                        if(!thisEnemy.enemy.isDead){
                            Rectangle()
                                .frame(width: thisEnemy.enemy.health*1, height: 10)
                                .foregroundColor(.green)
                                .position( CGPoint( x:thisEnemy.enemy.location.x,y:thisEnemy.enemy.location.y - 15))
                            Circle()
                                .frame(width: 15, height: 15)
                                .foregroundColor(thisEnemy.enemy.color)
                                .position(thisEnemy.enemy.location)
                        }
                    }
                }
                

                //Text("New Tower Location \(self.lastTapLocation.debugDescription)")
                //        .position(taplocation)
                
                
                Text("Lives \(self.player.Lives.stringWithoutTrailingZeros)")
                    .position(healthlocation)
                
                Text("Bank \(self.player.Bank.stringWithoutTrailingZeros)")
                    .position(banklocation)
                
                //DISPLAYING TOWERS
                ForEach(player.novelViews, id: \.id) { thisView in
                    //editDamage(thisView.location, updaterPos)
                    //cannon tower
                    
                    
                    if (towerStyle == 0){
                        //Tower itself
                        Rectangle().frame(width: 20, height: 20)
                            .offset(self.getOffset(thisView.tower.location))
                            .foregroundColor(Color(towerColor))
                        //Tower Range
                        Circle()
                            .strokeBorder(!thisView.tower.enemiesInRange.isEmpty ? Color.red : Color.black, lineWidth: 2)
                            .frame(width: 200, height: 200)
                            .offset(self.getOffset(thisView.tower.location))
                    }
                    
                    //Blowie tower
                    if (towerStyle == 1){
                        Rectangle().frame(width: 10, height: 10)
                            .offset(self.getOffset(thisView.tower.location))
                            .foregroundColor(Color(towerColor))
                        //Tower Range
                        Circle()
                            .strokeBorder(!thisView.tower.enemiesInRange.isEmpty ? Color.red : Color.black, lineWidth: 2)
                            .frame(width: 100, height: 100)
                            .offset(self.getOffset(thisView.tower.location))
                    }
                    
                    //pins tower
                    if (towerStyle == 2){
                        Rectangle().frame(width: 10, height: 10)
                            .offset(self.getOffset(thisView.tower.location))
                        .foregroundColor(Color(towerColor))
                        //Tower Range
                        Circle()
                            .strokeBorder(!thisView.tower.enemiesInRange.isEmpty ? Color.red : Color.black, lineWidth: 2)
                            .frame(width: 100, height: 100)
                            .offset(self.getOffset(thisView.tower.location))
                        //print(distance(a:updaterPos,b:thisView.location))
                    }
                }

            }.onAppear{ //This only happens once
                player.enemyViews.append(spawnEnemy(yOffset: -250))
            }
                .background(Color(backgroundColor))
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .updating($dragState) { drag, state, transaction in
                    state = .dragging(translation: drag.translation)
                }
                .onEnded{value in //end of tap gesture
                    let startLoc = value.startLocation
                    let endLoc = value.location
                    
                    //Buy new Tower and place down in location from end of tap gesture 
                    if (abs(startLoc.x - endLoc.x) <= 10 && abs(startLoc.y - endLoc.y) <= 10){
                        print("tap found")
                        //Ensure not on path
                        if ((startLoc.x < (UIScreen.main.bounds.width/2 - 30) || startLoc.x > (UIScreen.main.bounds.width/2 + 30)) && ( startLoc.y < (Height-Height/8))){
                            if(player.Bank >= 50){
                                player.novelViews.append(NewView(tower: Tower(location: startLoc)))
                                player.Bank -= 50
                            }
                        }
                        
                        
                    }
                }
                .onChanged{value in
                    self.lastTapLocation = value.startLocation
                    print("value changing")
                })
            .ignoresSafeArea()
        }
        .onReceive (self.timerT){ _ in
              withAnimation {
                  player.enemyViews.append(spawnRandom(yOffset: 30))
              }
        }
    }
    
    //Reset Level: towers, enemies, lives, and bank
    func resetLevel(){
        player.novelViews = []
        player.enemyViews = []
        player.enemyViews = appendNewWave(initialEV: [])
        player.Lives = LvlLives
        player.Bank = LvlBank
    }
    
    //Move local enemies
    func updateUpdater(){
        //off screen
        if(self.updaterPos.x < UIScreen.main.bounds.width+40){
            withAnimation{
                self.updaterPos.x += 1
            }
        }
        else{
            updaterPos.x = UIScreen.main.bounds.width/2
        }
    }
    
    //Return offset CGSize point
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

extension Double {
    var stringWithoutTrailingZeros: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
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
