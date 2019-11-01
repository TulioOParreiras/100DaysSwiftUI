//
//  ContentView.swift
//  iExpense
//
//  Created by Usemobile on 01/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: self.expenses)
            }
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






//struct User: Codable {
//    var firstName: String
//    var lastName: String
//}
//
////struct SecondView: View {
////    @Environment(\.presentationMode) var presentationMode
////    var name: String
////
////    var body: some View {
////        Button("Dismiss") {
////            self.presentationMode.wrappedValue.dismiss()
////        }
////    }
////}
//
////class User: ObservableObject {
////    @Published var firstName = "Bilbo"
////    @Published var lastName = "Baggins"
////}
//
//struct ContentView: View {
//
//    @State private var user = User(firstName: "Taylor", lastName: "Swift")
//
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
//
////    @State private var numbers = [Int]()
////    @State private var currentNumber = 1
//
////    @State private var showingSheet = false
//
////    @ObservedObject private var user = User()
//
//    var body: some View {
//
//        Button("Save User") {
//            let encoder = JSONEncoder()
//
//            if let data = try? encoder.encode(self.user) {
//                UserDefaults.standard.set(data, forKey: "UserData")
//            }
//        }
//
////        Button("Tap count: \(tapCount)") {
////            self.tapCount += 1
////            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
////        }
//
////        NavigationView {
////            VStack {
////                List {
////                    ForEach(numbers, id: \.self) {
////                        Text("\($0)")
////                    }
////                    .onDelete(perform: removeRows)
////                }
////
////                Button("Add Number") {
////                    self.numbers.append(self.currentNumber)
////                    self.currentNumber += 1
////                }
////            }
////        .navigationBarItems(leading: EditButton())
////        }
//
////        Button("Show Sheet") {
////            self.showingSheet.toggle()
////        }
////        .sheet(isPresented: $showingSheet) {
////            SecondView(name: "@twostraws")
////        }
//
////        VStack {
////            Text("Your name is \(user.firstName) \(user.lastName)")
////            TextField("First name", text: $user.firstName)
////            TextField("Last name", text: $user.lastName)
////        }
//    }
//
////    func removeRows(at offsets: IndexSet) {
////        numbers.remove(atOffsets: offsets)
////    }
//
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
