//
//  ContentView.swift
//  WeSplit
//
//  Created by Joey Hinckley on 2/22/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Form{
                Text("Hello World")
                Text("This is a form")
                Text("Hope you have a nice day")
                
                Section {
                    Text("Hello from another section")
                    Text("Swift is fun!")
                }
            }
            .navigationTitle("Forms in Swift")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
