//
//  ContentView.swift
//  DotsAndBoxes
//
//  Created by Joey Hinckley on 2/28/22.
//

import SwiftUI

struct ContentView: View {
    
    let backgroundColor = Color(red: 31/255, green: 195/255, blue: 65/255)
    let TowerColor = Color(red: 56/255, green: 116/255, blue: 172/255)
    
    let enemieStart = CGPoint(x: 0, y: 100)

    
    
//    @State private var xpos: CGFloat = 100
//    @State private var ypos: CGFloat = 20
    
   
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @StateObject var AllEnemies = Enemies()
    
    
    
    var body: some View {
        GeometryReader { reader in
            VStack{
                if AllEnemies.updater {
                    enemieView
                }else{
                    enemieView
                }


                let newNode = Node(position: enemieStart, health: 10)

                AllEnemies.nodes.append(newNode)

            }
            
            
            
//            VStack{
//                ZStack{
//                    //TO DO make this a loop LOL
//                    Pixel(size: 60, color: TowerColor)
//                        .position(x: 100, y: 40)
//                    Pixel(size: 60, color: TowerColor)
//                        .position(x: 200, y: 40)
//                    Pixel(size: 60, color: TowerColor)
//                        .position(x: 100, y: 140)
//                    Pixel(size: 60, color: TowerColor)
//                        .position(x: 200, y: 140)
//                    Pixel(size: 60, color: TowerColor)
//                        .position(x: 100, y: 240)
//                    Pixel(size: 60, color: TowerColor)
//                        .position(x: 200, y: 240)
//                    Pixel(size: 60, color: TowerColor)
//                        .position(x: 100, y: 340)
//                    Pixel(size: 60, color: TowerColor)
//                        .position(x: 200, y: 340)
//                    Pixel(size: 60, color: TowerColor)
//                        .position(x: 100, y: 440)
//                    Pixel(size: 60, color: TowerColor)
//                        .position(x: 200, y: 440)
//                }
//
//
//                VStack{
//                    Button {
//                        print("Campaign to the console")
//                    } label: {
//                        Text("Campaign")
//                            .font(.title)
//                            .frame(maxWidth: .infinity , maxHeight: 70)
//                            .foregroundColor(Color.black)
//                            .background(Color(red: 234/255, green: 156/255, blue: 153/255))
//                    }
                }
                
                
        
    //            Rectangle()
    //                .frame(width: 1000, height: 70)
    //                .foregroundColor(Color.cyan)
                    
            }
            .background(backgroundColor)
            .edgesIgnoringSafeArea(.all)
        }
       
            
    }
    
    @ViewBuilder
    var enemieView: some View {
        ForEach(AllEnemies.nodes) { node in
            NodeView(node: node)
        }
        
    }
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
