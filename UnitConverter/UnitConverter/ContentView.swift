//
//  ContentView.swift
//  UnitConverter
//
//  Created by Usemobile on 18/10/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var timeEntry = ""
    @State var currentUnit: Int = 1
    @State var conversionUnit: Int = 2
    
    
    enum AvailableUnits: String, CaseIterable {
        case miliseconds
        case seconds
        case minutes
        case hours
        case days
        case weeks
        case months
        case years
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Convert time")) {
                    TextField("Conversion time", text: self.$timeEntry)
                        .keyboardType(.numberPad)
                    Picker("Current unit", selection: self.$currentUnit) {
                        ForEach(0 ..< AvailableUnits.allCases.count) {
                            Text(AvailableUnits.allCases[$0].rawValue.capitalized)
                        }
                    }
                    Picker("Conversion unit", selection: self.$conversionUnit) {
                        ForEach(0 ..< AvailableUnits.allCases.count) {
                            Text(AvailableUnits.allCases[$0].rawValue.capitalized)
                        }
                    }
                    Text("Converted Time: ")
                    Text("\(self.getConvertedTime(), specifier: "%.2f") \(AvailableUnits.allCases[self.conversionUnit].rawValue.capitalized)")
                }
            }
            .navigationBarTitle("Time converter")
        }
    }
    
    func getConvertedTime() -> Double {
        let time: Double = Double(self.timeEntry) ?? 0
        let selectedUnit = AvailableUnits.allCases[self.currentUnit]
        var timeInMiliseconds: Double = 0
        switch selectedUnit {
        case .miliseconds:
            timeInMiliseconds = time
        case .seconds:
            timeInMiliseconds = time * 60
        case .minutes:
            timeInMiliseconds = time * 60 * 60
        case .hours:
            timeInMiliseconds = time * 60 * 60 * 60
        case .days:
            timeInMiliseconds = time * 60 * 60 * 60 * 24
        case .weeks:
            timeInMiliseconds = time * 60 * 60 * 60 * 24 * 7
        case .months:
            timeInMiliseconds = time * 60 * 60 * 60 * 24 * 7 * 30
        case .years:
            timeInMiliseconds = time * 60 * 60 * 60 * 24 * 7 * 30 * 12
        }
        let newUnit = AvailableUnits.allCases[self.conversionUnit]
        var convertedTime: Double = 0
        
        switch newUnit {
        case .miliseconds:
            convertedTime = timeInMiliseconds
        case .seconds:
            convertedTime = timeInMiliseconds / 60
        case .minutes:
            convertedTime = timeInMiliseconds / 60 / 60
        case .hours:
            convertedTime = timeInMiliseconds / 60 / 60 / 60
        case .days:
            convertedTime = timeInMiliseconds / 60 / 60 / 60 / 24
        case .weeks:
            convertedTime = timeInMiliseconds / 60 / 60 / 60 / 24 / 7
        case .months:
            convertedTime = timeInMiliseconds / 60 / 60 / 60 / 24 / 7 / 30
        case .years:
            convertedTime = timeInMiliseconds / 60 / 60 / 60 / 24 / 7 / 30 / 12
        }
        
        return convertedTime
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
