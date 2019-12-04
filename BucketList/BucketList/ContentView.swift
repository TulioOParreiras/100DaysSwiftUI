//
//  ContentView.swift
//  BucketList
//
//  Created by Usemobile on 04/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import LocalAuthentication
import MapKit
import SwiftUI 

struct ContentView: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = MKPointAnnotation()
                        newLocation.title = "Example Location"
                        newLocation.coordinate = self.centerCoordinate
                        self.locations.append(newLocation)
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .alert(isPresented: $showingPlaceDetails, content: {
            Alert(title: Text(self.selectedPlace?.title ?? "Unknown"), message: Text(self.selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                
                })
        })
    }
    
    
}












//
//
//struct LoadingView: View {
//    var body: some View {
//        Text("Loading")
//    }
//}
//
//struct SuccessView: View {
//    var body: some View {
//        Text("Success")
//    }
//}
//
//struct FailedView: View {
//    var body: some View {
//        Text("Failed")
//    }
//}
//
//struct User: Identifiable, Comparable  {
//    let id = UUID()
//    let firstName: String
//    let lastName: String
//
//    static func < (lhs: User, rhs: User) -> Bool {
//        lhs.lastName < rhs.lastName
//    }
//}
//
//struct ContentView: View {
//
//    enum LoadingState {
//        case loading, success, failed
//    }
//
//    var loadingState = LoadingState.loading
//
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//
//    let users = [
//        User(firstName: "Arnold", lastName: "Rimmer"),
//        User(firstName: "Kristine", lastName: "Kochanski"),
//        User(firstName: "David", lastName: "Lister")
//    ].sorted()
//
//@State private var isUnlocked = false
//
//
//
//    var body: some View {
//
//    VStack {
//        if self.isUnlocked {
//            Text("Unlocked")
//        } else {
//            Text("Locked")
//        }
//    }
//.onAppear(perform: authenticate)

//        MapView()
//            .edgesIgnoringSafeArea(.all)
//
////        Group {
////            if self.loadingState == .loading {
////                LoadingView()
////            } else if self.loadingState == .success {
////                SuccessView()
////            } else if self.loadingState == .failed {
////                FailedView()
////            }
////        }
//
////        Text("Hello World")
////            .onTapGesture {
////                let str = "Test Message"
////                let url = self.getDocumentsDirectory().appendingPathComponent("message.txt")
////
////                do {
////                    try str.write(to: url, atomically: true, encoding: .utf8)
////                    let input = try String(contentsOf: url)
////                    print(input)
////                } catch {
////                    print(error.localizedDescription)
////                }
////        }
//
////        List(users) { user in
////            Text("\(user.lastName), \(user.firstName)")
////        }
//    }
//
//
//func authenticate() {
//    let context = LAContext()
//    var error: NSError?
//
//    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//        let reason = "We need to unlock your data."
//
//        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
//            if success {
//                self.isUnlocked = true
//            } else {
//
//            }
//        }
//    } else {
//
//    }
//}
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
