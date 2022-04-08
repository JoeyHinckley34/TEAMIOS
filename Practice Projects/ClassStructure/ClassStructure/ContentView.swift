//
//  ContentView.swift
//  ClassStructure
//
//  Created by administrator on 4/8/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appData: AppData = AppData()
    @State private var page = 0

    var body: some View {
        if (page == 0) {
            VStack {
                GameView(appData: appData)
                HStack {
                    Spacer()
                    Button("Play") {
                        self.page = 1
                    }
                    Spacer()
                    Button("Create") {
                        self.page = 2
                    }
                    Spacer()
                }
            }
        }
        else if (page == 1) {
            VStack {
                LevelSelectView()
                Button("Back") {
                    self.page = 0
                }
            }
        }
        else if (page == 2) {
            VStack {
                LevelManageView()
                Button("Back") {
                    self.page = 0
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
