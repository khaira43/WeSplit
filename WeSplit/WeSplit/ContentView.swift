//
//  ContentView.swift
//  WeSplit
//
//  Created by Ranbir Khaira on 2025-03-12.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPrecentage = 20 //three states for three things that will be input
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [10, 15, 20, 25, 0]
    //wont change so not state
    var totalCheck : Double {
        let tipSelection = Double(tipPrecentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
        
    }
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPrecentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
        
    }
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)//makes a text field that sends values to checkamount, formats as local currecy
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)//a picker instead of a text field works same way, uses loop to add values
                }
                Section ("How much tip do you want to leave?"){
                    Picker("Tip precentage", selection: $tipPrecentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.navigationLink)
//                    Picker("Tip percentage", selection: $tipPrecentage) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
//                    }.pickerStyle(.segmented)//segmented style
                }//picker from an array
                Section ("Amount per person:"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }//displays checkamount if currency format
                //when state changes, body is reinvoked
                Section ("Total Check:"){
                    Text(totalCheck, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }.navigationTitle("WeSplit").toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
