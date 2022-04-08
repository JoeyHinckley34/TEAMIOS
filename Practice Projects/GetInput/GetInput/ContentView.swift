//
//  ContentView.swift
//  GetInput
//
//  Created by Joey Hinckley on 2/22/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name = ""
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Enter your name", text: $name)
                Text("Your name: \(name)")
            }
            .navigationTitle("User Input")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
