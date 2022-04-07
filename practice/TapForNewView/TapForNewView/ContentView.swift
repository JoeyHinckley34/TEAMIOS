//
//  ContentView.swift
//  TapForNewView
//
//  Created by Joey Hinckley on 3/21/22.
//
import SwiftUI

class Player: Identifiable {
    var Bank:Double
    var Lives:Double
    init(bank: Double, lives: Double){
        Bank = bank
        Lives = lives
    }
}

struct ContentView: View {
    
    @State private var enemiePosition = CGPoint(x: UIScreen.main.bounds.width/2, y:-10)
    @State private var enemieHealth:CGFloat = 10
    
    @State private var damage:Int = 0
    
    //tower types
    var towers = ["Cannon","Blowie","Pins"]
    @State private var towerStyle = 0
    
    //@State private var Lives:Double = 20
    //@State private var Bank:Double = 1000
    var player:Player = Player(bank: 1000, lives: 20)
//    @State private var Reset
    
    @State var novelViews:[NewView] = []
    @State var enemyViews:[EnemieView] = appendNewWave(initialEV: [])
    @State var lastTapLocation:CGPoint = .zero

    var Width : CGFloat {
        get {
            return UIScreen.main.bounds.width
        }
    }
    
    private let Height:CGFloat = UIScreen.main.bounds.height

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
    
//    let path = { CGPoint(x: UIScreen.main.bounds.width/2, y: .zero), CGPoint(x: 200, y: UIScreen.main.bounds.height/2), CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height);
//    }
    
    let timerPT = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    let timerT = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    @GestureState private var dragState = DragState.inactive
    
    let pathColor = CGColor(red: 1, green: 0.85, blue: 0.24, alpha: 1)
    let MenuColor = CGColor(red: 1, green: 0.89, blue: 0.74, alpha: 1)
    let towerColor = CGColor(red: 0.20, green: 0.24, blue: 51, alpha: 1)
    let backgroundColor = CGColor(red: 0.42, green: 0.80, blue: 0.47, alpha: 1)
    
    
    
    var body: some View {
        
        //These do execute and change enemy values but do not alter array (not remove/append)
        //enemyViews = appendNewWave(initialEV: enemyViews)
        
        player.Lives -= moveEnemies(enemyViewsArray: enemyViews)

        for t in novelViews {
            t.tower.detectEnemies(enemyArray: enemyViews)
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
                
               
                
                Button ("Reset \n Tower: \(self.towers[self.towerStyle])"){
                    resetTowers()
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
                    //*
                    //This needs to be running to have the code run continuous, not stop when wait for tap gesture
                    let NewEnemy = Enemy(position: enemiePosition) //the ONLY enemy
                    EnemieView (enemy: NewEnemy)
                        .onReceive(self.timerPT){ _ in
                            self.moveEnemy()
                            for thisView in novelViews{
                                self.editDamage(enemyPosition: NewEnemy.location, towerPostition: thisView.tower.location)
                            }
                        }//*/
                    
                    ForEach(enemyViews, id: \.id) { thisEnemy in
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
                
                //Text("\(enemyViews.count)")
                
                
                //self.damage = 0
                //loop throughh every view and add two rectangle at its location and one for the body and one for the range
                
                //DISPLAYING TOWERS
                ForEach(novelViews, id: \.id) { thisView in
                    //editDamage(thisView.location, enemiePosition)
                    //cannon tower
                    if (towerStyle == 0){
                        //Tower itself
                        Rectangle().frame(width: 20, height: 20)
                            .offset(self.getOffset(thisView.tower.location))
                            .foregroundColor(Color(towerColor))
                        //Tower Range
                        Circle()
                            .strokeBorder((abs(enemiePosition.y - thisView.tower.location.y) < 100 && abs(enemiePosition.x - thisView.tower.location.x) < 100) || !thisView.tower.enemiesInRange.isEmpty ? Color.red : Color.black, lineWidth: 2)
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
                            .strokeBorder(abs(enemiePosition.y - thisView.tower.location.y) < 100 && abs(enemiePosition.x - thisView.tower.location.x) < 100 ? Color.red : Color.black, lineWidth: 2)
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
                            //.strokeBorder(distanceFormula(a:enemiePosition,b:thisView.location) < 100 ? Color.red : Color.black, lineWidth: 2)
                            .frame(width: 100, height: 100)
                            .offset(self.getOffset(thisView.tower.location))
                        //print(distance(a:enemiePosition,b:thisView.location))
                    }
                    //Rectangle()
                    
                    //with accurate range?
//                    if (towerStyle == 1){
//                        Rectangle().frame(width: 10, height: 10)
//                            .offset(self.getOffset(thisView.location))
//                            .foregroundColor(Color(towerColor))
//                        //Tower Range
//                        Circle()
//                            //.strokeBorder(sqrt(pow(enemiePosition.y-thisView.location.y,2)+pow(enemiePosition.x-thisView.location.x, 2))) < 100 ? Color.red : Color.black, lineWidth: 2)
//                            .frame(width: 100, height: 100)
//                            .offset(self.getOffset(thisView.location))
//                    }
                    
                    
                    
                    
           
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
                    
                }
//
                        
           
            }.onAppear{ //This only happens once
                enemyViews.append(spawnEnemy(yOffset: -250))
            }
            
                //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(Color(backgroundColor))
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
                        if ((startLoc.x < (UIScreen.main.bounds.width/2 - 30) || startLoc.x > (UIScreen.main.bounds.width/2 + 30)) && ( startLoc.y < (Height-Height/8))){
                            if(player.Bank >= 50){
                                self.novelViews.append(NewView(tower: Tower(location: startLoc)))
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
    }
    
//    func distanceFormula(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
//        let xDist = a.x - b.x
//        let YDist = a.y - b.y
//        return CGFloat(sqrt(xDist * xDist + YDist * YDist))
//    }
    
    func editDamage(enemyPosition: CGPoint, towerPostition: CGPoint){
        if(abs(enemiePosition.y - towerPostition.y) < 100 && abs(enemiePosition.x - towerPostition.x) < 100){
            enemieHealth -= 1
            damage+=1
        }
        if(enemieHealth < 0){
            enemieHealth = 10
            self.enemiePosition.y = -10
            player.Bank += 30
        }
        
    }
    
    func resetTowers(){
        self.novelViews = []
        //Loop through all enemies
        self.enemiePosition = CGPoint(x: UIScreen.main.bounds.width/2, y:-10)
    }
    
    func moveEnemy(){
        //off screen
        if(self.enemiePosition.y > UIScreen.main.bounds.height+10){
            self.enemiePosition.y = -10
            player.Lives -= 1
            enemieHealth = 10
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
