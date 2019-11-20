////
////  DetailsView.swift
////  HabitTracking
////
////  Created by Usemobile on 20/11/19.
////  Copyright © 2019 Usemobile. All rights reserved.
////
//
//import SwiftUI
//
//struct DetailsView: View {
//    @ObservedObject var habitsList: HabitsList
//    var selectedHabit: Int
//    var habit: Habit {
//        return self.habitsList.habits[self.selectedHabit]
//    }
//    
//    var body: some View {
//        ScrollView(.vertical) {
//            
//            HStack(alignment: .top) {
//                VStack {
//                    Text(self.habit.name)
//                        .padding(15)
//                    Text(self.habit.description)
//                        .padding(15)
//                    
//                    HStack {
//                        Spacer()
//                        Text("Count: \(self.habit.count)")
//                        Spacer()
//                        Button(action: {
//                            self.habitsList.habits[self.selectedHabit].increment()
//                        }) {
//                            Image(systemName: "plus")
//                        }
//                        Spacer()
//                    }
//                    //                    Spacer()
//                }
//            }
//        }
//    }
//}
//
//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView(habitsList: HabitsList(), selectedHabit: 0)
//    }
//}
