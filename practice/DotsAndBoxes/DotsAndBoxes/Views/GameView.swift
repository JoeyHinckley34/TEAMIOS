//
//  GameView.swift
//  DotsAndBoxes
//
//  Created by administrator on 3/28/22.
//

import SwiftUI

struct GameView: View {
    @State var game: Game
    
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
            Spacer()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {

        var level: Level = Level(name: "Level 1")
        
        var game: Game = Game(level: level, mode: 1)
        
        GameView(game: game)
    }
}
