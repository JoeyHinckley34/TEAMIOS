//
//  ContentView.swift
//  CheckSplit
//
//  Created by Joey Hinckley on 2/22/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 3
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 1)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
        
    }
    
    
    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker ("Number of People", selection: $numberOfPeople){
                        ForEach(1..<100) { i in
                            if (i == 1) {
                                Text("\(i) person")
                            }
                            else {
                                Text("\(i) people")
                            }
                        }
                    }
                }
                
                Section {
                    Picker ("Tip Percentage", selection: $tipPercentage ) {
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
                
            }
            .navigationTitle("Check Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
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
