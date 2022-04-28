//
//  ContentView.swift
//  DotsAndBoxes
//
//  Created by Joey Hinckley on 3/21/22.
//
import SwiftUI

// Mutable Player Data
class Player: Identifiable {
    var Bank: Double
    var Lives: Double
    var towerViews: [TowerView] = []
    var towerLocations: [CGPoint] = []
    var enemyViews: [EnemieView] = appendNewWave(initialEV: [])
    var firstRun: Bool
    init(bank: Double, lives: Double) {
        Bank = bank
        Lives = lives
        firstRun = true
    }
}

class LevelInfo{
    //element 0 represents the info for level 0, 1 for level 1, etc
    var Bank: [Double] = [200, 300, 500, 1000]
    var Lives: [Double] = [5, 7, 10, 1]
    init(){}
}

// Main Display and Game Calculations
struct ContentView: View {

    @State private var updaterPos = CGPoint(x: UIScreen.main.bounds.width/2, y: -100)
    @State private var enemieHealth: CGFloat = 10
    @State private var damage: Int = 0

    // tower types
    var towers = ["Default", "FlameThrower", "Sniper", "Sell"]
    @State private var towerStyle = 0

    //Dynamic Level Info and Stats
    var lvlInfo: LevelInfo = LevelInfo()
    var lvl: Int = 0
    var player: Player = Player(bank: 200, lives: 5)

    @State var lastTapLocation: CGPoint = .zero

    var Width: CGFloat {
        return UIScreen.main.bounds.width
    }

    private let Height: CGFloat = UIScreen.main.bounds.height

    // Player info Displays
    var towerSelectLocation: CGPoint {
        return CGPoint(x: Width/5, y: Height-(1*Height/16)-40)
    }
    var healthlocation: CGPoint {
        return CGPoint(x: Width-Width/5, y: Height-(15*Height/16)-40)
    }
    var banklocation: CGPoint {
        return CGPoint(x: Width/5, y: Height-(15*Height/16)-40)
    }
    var lvlLocation: CGPoint {
        return CGPoint(x: Width/2, y: 10)
    }
    var ResetLocation: CGPoint {
        return CGPoint(x: Width-Width/5, y: Height-(1*Height/16)-40)
    }

    let start = CGPoint(x: UIScreen.main.bounds.width/2, y: .zero)
    let pt1 = CGPoint(x: 200, y: UIScreen.main.bounds.height/2)
    let end = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)
    let timerPT = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    let timerT = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    @GestureState private var dragState = DragState.inactive
    let menuOffset: CGFloat = 40
    let distanceBetweenTowers: CGFloat = 30

    //Level UI Colors
    let pathColor = CGColor(red: 1, green: 0.85, blue: 0.24, alpha: 1)
    let MenuColor = CGColor(red: 1, green: 0.89, blue: 0.74, alpha: 1)
    let backgroundColor = CGColor(red: 0.42, green: 0.80, blue: 0.47, alpha: 1)

    var body: some View {
        checkValues()
        
        // Move enemies and subtract lives if get to player
        player.Lives -= moveEnemies(enemyViewsArray: player.enemyViews)

        if player.Lives <= 0 {
            resetLevel()
        }
        // towers find enemies and attack those in range
        for t in player.towerViews {
            t.tower.detectEnemies(enemyArray: player.enemyViews)
            player.Bank += t.tower.attack()
        }
        
        return Group {
            ZStack {
                // Menu Path
                Path { path in
                    path.move(to: CGPoint(x: 0, y: Height))
                    path.addLine(to: CGPoint(x: Width, y: Height))
                }
                    .stroke(Color(cgColor: MenuColor), lineWidth: Height/4)

                Button("Reset") {
                    resetLevel()
                }
                    .padding()
                    .foregroundColor(.red)
                    .position(ResetLocation)

                Picker(selection: $towerStyle, label: Text("")) {
                    ForEach(0 ..< towers.count, id: \.self) { i in
                        Text(towers[i])
                    }
                }
                    .padding()
                    .pickerStyle(MenuPickerStyle())
                    .position(towerSelectLocation)

                Path { path in
                    path.move(to: start)
                    // path.addLine(to: pt1)
                    path.addLine(to: end)
                }
                    .stroke(Color(cgColor: pathColor), lineWidth: 50)

                // DISPLAYING ENEMIES
                Group {
                    // This needs to be running to have the code run continuous, not stop when wait for tap gesture
                    let updater = Enemy(position: updaterPos) // the ONLY enemy
                    EnemieView(enemy: updater)
                        .onReceive(self.timerPT) { _ in
                            self.updateUpdater()
                        }

                    ForEach(player.enemyViews, id: \.id) { thisEnemy in
                        if !thisEnemy.enemy.isDead {
                            Rectangle()
                                .frame(width: thisEnemy.enemy.health*1, height: 10)
                                .foregroundColor(.green)
                                .position( CGPoint( x: thisEnemy.enemy.location.x, y: thisEnemy.enemy.location.y - 15))
                            Circle()
                                .frame(width: 15, height: 15)
                                .foregroundColor(thisEnemy.enemy.color)
                                .position(thisEnemy.enemy.location)
                        }
                    }
                }

                // DISPLAY Player Values (lives, bank) and Level
                Text("Lives \(self.player.Lives.stringWithoutTrailingZeros)")
                    .position(healthlocation)

                Text("Bank \(self.player.Bank.stringWithoutTrailingZeros)")
                    .position(banklocation)
                
                Text("Level \(self.lvl)")
                    .position(lvlLocation)

                // DISPLAYING TOWERS
                ForEach(player.towerViews, id: \.id) { thisView in
                    let thisTower: Tower = thisView.tower
                    let reloadBoxWidth: CGFloat = 20
                    let reloadPercent: CGFloat = thisTower.currentTick / thisTower.shootTick
                    let reloadProgressWidth: CGFloat = reloadBoxWidth * reloadPercent

                    // Display current Tower, aka thisTower (aka thisView.tower)
                        Rectangle() // Reload Display Back
                            .frame(width: reloadBoxWidth, height: 10)
                            .foregroundColor(.red)
                            .position( CGPoint( x: thisTower.location.x, y: thisTower.location.y - 15))
                        Rectangle() // Reload Display Front
                            .frame(width: reloadProgressWidth, height: 10)
                            .foregroundColor(.green)
                            .position( CGPoint( x: thisTower.location.x-(reloadBoxWidth)/2+(reloadProgressWidth)/2,
                                                y: thisTower.location.y - 15) )
                        Rectangle().frame(width: 10, height: 10) // Tower Display
                            .offset(self.getOffset(thisTower.location))
                            .foregroundColor(thisTower.color)
                            .frame(width: 15, height: 15)
                        Circle() // Tower Range
                            .strokeBorder(!thisTower.enemiesInRange.isEmpty ? Color.red : Color.black, lineWidth: 2)
                            .frame(width: thisTower.range*2, height: thisTower.range*2)
                            .offset(self.getOffset(thisTower.location))
                }

            }
                .background(Color(backgroundColor))
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .updating($dragState) { drag, state, _ in
                    state = .dragging(translation: drag.translation)
                }
                .onEnded { value in // end of tap gesture
                    var startLoc = value.startLocation
                    let endLoc = value.location

                    //Sell Tower or Buy new Tower and place down in location from start of tap gesture
                    //If statement below checks if it was a valid tap, invalid taps are long draging motions, thus start-end > 10
                    if abs(startLoc.x - endLoc.x) <= 10 && abs(startLoc.y - endLoc.y) <= 10 {
                        print("tap found")
                        startLoc = CGPoint(x: startLoc.x, y: startLoc.y - menuOffset)
                        
                        //SELL
                        if(towerStyle == 3){
                            assert(towers[towerStyle] == "Sell")
                            sellTower(start: startLoc)
                        }
                        
                        //Check if can buy
                        else if(validTowerPlacement(start: startLoc)){
                            let newTower: TowerView
                            //Determine desired tower type
                            switch towerStyle {
                            case 1:
                                newTower = TowerView(tower: FlameThrower(location: startLoc))
                            case 2:
                                newTower = TowerView(tower: Sniper(location: startLoc))
                            default:
                                newTower = TowerView(tower: Tower(location: startLoc))
                            }
                            //Buy
                            if player.Bank >= newTower.tower.cost {
                                player.towerLocations.append(startLoc)
                                player.towerViews.append(newTower)
                                player.Bank -= newTower.tower.cost
                            }
                        }
                    }
                }
                .onChanged { value in
                    self.lastTapLocation = value.startLocation
                    print("value changing")
                })
            .ignoresSafeArea()
        }
        .onReceive(self.timerT) { _ in
              withAnimation {
                  player.enemyViews.append(spawnRandom(yOffset: 30))
              }
        }
    }
    
    func sellTower(start: CGPoint){
        //Find tower location if exists
        var sellingTowerLocation: CGPoint = CGPoint(x: .zero, y:-100) //not possible to place a tower here
        for towerLocation in player.towerLocations {
            if((start.x > (towerLocation.x - 5) && start.x < (towerLocation.x + 5)) &&
               (start.y > (towerLocation.y - 5) && start.y < (towerLocation.y + 5))) {
                sellingTowerLocation = towerLocation
                break
            }
        }
        
        //sell tower
        if(sellingTowerLocation != CGPoint(x: .zero, y:-100)){
            //Find the tower with this location
            //Remove it from player.towerViews and player.towerLocations
            let old = player.towerViews
            let tvUpdated = player.towerViews.filter { $0.tower.location != sellingTowerLocation }
            let tlUpdated = player.towerLocations.filter { $0 != sellingTowerLocation }
            player.towerViews = tvUpdated
            player.towerLocations = tlUpdated
            
            var removed: [TowerView] = []
            for t in tlUpdated {
                removed = old.filter { $0.tower.location != t }
            }
            //Add currency back to bank
            if(removed.isEmpty){  return  } //prevents index out of range from below's command
            player.Bank += removed[0].tower.cost/2
        }
        
    }
    
    func validTowerPlacement(start: CGPoint) -> Bool{
        var tooClose: Bool = false
        for towerLocation in player.towerLocations {
            if((start.x > (towerLocation.x - distanceBetweenTowers) && start.x < (towerLocation.x + distanceBetweenTowers)) &&
               (start.y > (towerLocation.y - distanceBetweenTowers) && start.y < (towerLocation.y + distanceBetweenTowers))) {
                tooClose = true
            }
        }
        let notOnPath: Bool = (start.x < (UIScreen.main.bounds.width/2 - 30) || start.x > (UIScreen.main.bounds.width/2 + 30)) && start.y < (Height-Height/8)
        return !tooClose && notOnPath
    }
    
    func checkValues(){
        if(player.firstRun){
            player.firstRun = false
            resetLevel()
        }
    }

    // Reset Level: towers, enemies, lives, and bank
    func resetLevel() {
        player.towerViews = []
        player.towerLocations = []
        player.enemyViews = []
        player.enemyViews = appendNewWave(initialEV: [])
        player.Bank =  lvlInfo.Bank[lvl]
        player.Lives = lvlInfo.Lives[lvl]
        enemiesSpawned = 0
    }

    // Move local enemies
    func updateUpdater() {
        // off screen
        if self.updaterPos.x < UIScreen.main.bounds.width+20 {
            withAnimation {
                self.updaterPos.x += 1
            }
        } else {
            updaterPos.x = UIScreen.main.bounds.width/2
        }
    }

    // Return offset CGSize point
    func getOffset(_ originalOffset: CGPoint) -> CGSize {
        let xOffset = (-1 * (UIScreen.main.bounds.width/2) + originalOffset.x)
        let yOffset = (-1 * (UIScreen.main.bounds.height/2) + originalOffset.y)
        return CGSize(width: xOffset, height: yOffset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let levelPreview = 0
    
    static var previews: some View {
        ContentView(lvl: levelPreview)
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

    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }

    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}
