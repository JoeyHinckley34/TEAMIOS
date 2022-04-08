//
//  ContentView.swift
//  Button
//
//  Created by Joey Hinckley on 2/22/22.
//

import SwiftUI

struct ContentView: View {
    @State private var ClickCount = 1
    
    var body: some View {
        Button ( "Tap Count: \(ClickCount)"){
            ClickCount += 1
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
