//
//  ContentView.swift
//  WeSplit
//
//  Created by Joey Hinckley on 2/22/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Form{
            Text("Hello World")
            Text("This is a form")
            Text("Hope you have a nice day")
            
            Section {
                Text("Hello from another section")
                Text("Swift is fun!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
