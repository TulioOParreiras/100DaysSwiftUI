//
//  ContentView.swift
//  WeSplit
//
//  Created by Usemobile on 17/10/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
//    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    @State private var persons = ""
    @State private var isZeroTip = false
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var tipValue: Double {
        let tipSelection = Double(self.tipPercentages[self.tipPercentage])
        let orderAmount = Double(self.checkAmount) ?? 0
        
        return orderAmount / 100 * tipSelection
    }
    
    var totalAmount: Double {
        let orderAmount = Double(self.checkAmount) ?? 0
        
        return self.tipValue + orderAmount
    }
    
    var totalPerPerson: Double {
        // Calculate the total per person here
        let peopleCount = Double(self.persons) ?? 0
        
        let tipValue = self.tipValue
        let grandTotal = self.totalAmount
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var hasTip: Bool {
        let tip = self.tipPercentages[self.tipPercentage]
        return tip > 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Amount")) {
                    TextField("Amount", text: self.$checkAmount)
                        .keyboardType(.decimalPad)
//
////                    Picker("Number of people", selection: self.$numberOfPeople) {
////                        ForEach(2 ..< 100) {
////                            Text("\($0) people")
////                        }
////                    }
//
//                    TextField("Number of people", text: self.$persons)
//                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Number of people")) {
                    TextField("Number of people", text: self.$persons)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: self.$tipPercentage) {
                        ForEach(0 ..< self.tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total amount")) {
                    Text("Amount: $\(Double(self.checkAmount) ?? 0, specifier: "%.2f")")
                    Text("Tip: $\(self.tipValue, specifier: "%.2f")")
                        .foregroundColor(self.hasTip ? .blue : .red)
                    Text("Total: $\(self.totalAmount, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            
        .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
