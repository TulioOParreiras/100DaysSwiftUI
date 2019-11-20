//
//  ContentView.swift
//  HabitTracking
//
//  Created by Usemobile on 20/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var habitsList = HabitsList()
    
    @State private var showingAddView = false
    
    var body: some View {
        
        NavigationView {
            List(self.habitsList.habits) { habit in
//                NavigationLink(destination: DetailsView(habitsList: self.habitsList, selectedHabit: self.habitsList.getRow(for: habit))) {
                    VStack(alignment: .leading) {
                        Text(habit.name)
                    }
//                }
            }
                
                .navigationBarTitle("My Habits")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddView = true
                }) {
                    Image(systemName: "plus")
                }
            )
                .sheet(isPresented: $showingAddView, content: {
                    AddView(habitsList: self.habitsList)
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
