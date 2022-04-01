//
//  GameView.swift
//  DotsAndBoxes
//
//  Created by administrator on 3/28/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var appData: AppData
    
    var game: Game {
        appData.runningGame
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text(String(format: "Wave %d/%d", game.wave, game.level.waves.count))
                    Text(String(format: "$%d", game.money))
                }
                Spacer()
                Text(String(game.level.name))
                Spacer()
                VStack {
                    Text("")
                    Text(String(format: "%d Lives", game.lives))
                }
                Spacer()
            }
            ZStack(alignment: .topLeading) {
                Path { path in
                    path.move(to: game.level.path[0])
                    path.addLine(to: game.level.path[1])
                }
                .stroke(.green, lineWidth: 50)
                
                ForEach(game.enemies) { enemy in
                    EnemyView(enemy: enemy)
                }
                
                ForEach(game.towers) { tower in
                    TowerView(tower: tower)
                }
                
                Button("Next Wave") {
                    game.lives -= 1
                }
                .padding()
            }
        }
        
    }
    
//    init(appData: AppData) {
//        self.appData = appData
//        self.game = appData.runningGame
//    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {

        var appData = AppData()
        
        GameView(appData: appData)
    }
}
