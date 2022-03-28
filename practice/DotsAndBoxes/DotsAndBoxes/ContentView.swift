//
//  ContentView.swift
//  DotsAndBoxes
//
//  Created by administrator on 3/25/22.
//

import SwiftUI

struct ContentView: View {
    @State var app: AppData = AppData()
    
    var body: some View {
        NavigationView {
            VStack {
                GameView(game: app.runningGame)
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: LevelSelectView()) {
                        Text("Play")
                    }
                    Spacer()
                    NavigationLink(destination: LevelManageView()) {
                        Text("Create")
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
