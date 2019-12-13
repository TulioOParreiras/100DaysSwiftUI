//
//  ContentView.swift
//  HotProspects
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI
import UserNotifications

import SamplePackage

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
    
    @State private var backgroundColor = Color.red
    
    let possibleNumbers = Array(1...60)
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
        
//        VStack {
//            Button(action: requestNotificationPermission) {
//                Text("Request Permission")
//            }
//
//            Button(action: triggerLocalNotification) {
//                Text("Schedule Notification")
//            }
//        }
        
//        VStack {
//        Text("Hello, World!")
//            .padding()
//            .background(backgroundColor)
//
//        Text("Change Color")
//            .padding()
//            .contextMenu {
//                Button(action: {
//                    self.backgroundColor = .red
//                }) {
//                    Text("Red")
//                }
//
//                Button(action: {
//                    self.backgroundColor = .green
//                }) {
//                    Text("Green")
//                }
//
//                Button(action: {
//                    self.backgroundColor = .blue
//                }) {
//                    Text("Blue")
//                }
//            }
//        }
            
//        Image("example")
////            .interpolation(.none)
//            .resizable()
//            .scaledToFit()
//            .frame(maxHeight: .infinity)
//            .background(Color.black)
//            .edgesIgnoringSafeArea(.all)
        
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
    
    fileprivate func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    fileprivate func triggerLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.sound = UNNotificationSound.default
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.000000000000000000000005, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
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
