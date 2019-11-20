//
//  AddView.swift
//  HabitTracking
//
//  Created by Usemobile on 20/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habitsList: HabitsList
    @State private var habitName: String = ""
    @State private var habitDescription: String = ""
//    @State private var isConfirmEnabled: Bool = false
    
    var body: some View {
        VStack {
            Text("Add a new Habit")
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            
            VStack{
                TextField("Name", text: $habitName)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                TextField("Description", text: $habitDescription)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            
            HStack(alignment: .center) {
                Button(action: {
                    guard !self.habitName.isEmpty, !self.habitDescription.isEmpty else { return }
                    self.habitsList.insertHabit(Habit(name: self.habitName, description: self.habitDescription))
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Confirm")
                }
                
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            
            
            Spacer()
            
        }
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habitsList: HabitsList())
    }
}
