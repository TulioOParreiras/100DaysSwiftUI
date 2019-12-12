//
//  ContentView.swift
//  HotProspects
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

class DelayedUpdater: ObservableObject {
    
//    @Published var value = 0
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

enum NetworkError: Error {
    case badURL, requestFailed, unknown
    
    var message: String {
        switch self {
        case .badURL:
            return "badURL"
        default:
            return "Any"
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var updater = DelayedUpdater()
    
    let user = User()
    
    @State private var selectedTab = 0

    var body: some View {
        
        Image("example")
//            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
        
//        Text("Value is: \(updater.value)")
        
//        self.thatReturns { (result) in
//            switch result {
//            case .success(let text):
//                print(text)
//            case .failure(let error):
//                switch error {
//                case is NetworkError:
//                    switch error as? NetworkError {
//                    case .badURL:
//                        print("Bad URL")
//                    case nil:
//                        print("nil")
//                    default:
//                        print("Top")
//                    }
//                default:
//                    print(error.localizedDescription)
//                }
//            }
//        }
        
//        return TabView(selection: $selectedTab) {
//
//                Text("Tab 1")
//                    .onTapGesture {
//                        self.selectedTab = 1
//                }
//                    .tabItem {
//                        Image(systemName: "star")
//                        Text("One")
//                    }
//
//            Text("Tab 2")
//                .tabItem {
//                    Image(systemName: "star.fill")
//                    Text("Two")
//                }
//            .tag(1)
//        }
        
//
//        VStack {
//            EditView()
//            DisplayView()
//        }
//        .environmentObject(user)
    }
    
    func thatReturns(completion: @escaping (Result<String, Error>) -> Void) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct EditView: View {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}
