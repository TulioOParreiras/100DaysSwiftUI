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
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var isUnlocked = false
    @State private var showingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        let showingAlert = Binding<Bool>(
            get: {
                self.showingError || self.showingPlaceDetails
        },
            set: {
                self.showingError = $0
                self.showingPlaceDetails = $0
        }
        )
        
        return ZStack {
            if isUnlocked {
                ContainerView(centerCoordinate: self.$centerCoordinate, locations: self.$locations, selectedPlace: self.$selectedPlace, showingPlaceDetails: self.$showingPlaceDetails, showingEditScreen: self.$showingEditScreen)
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: showingAlert, content: {
            if self.showingPlaceDetails {

                return Alert(title: Text(self.selectedPlace?.title ?? "Unknown"), message: Text(self.selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                    self.showingEditScreen = true
                    })
            } else {

                return Alert(title: Text("Ops..."), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
            }
        })
            .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
                if self.selectedPlace != nil {
                    EditView(placemark: self.selectedPlace!)
                }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data: \(error)")
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        if let error = authenticationError {
                            self.errorMessage = error.localizedDescription
                            self.showingError = true
                        } else {
                            
                            self.errorMessage = "Unknown error occurred."
                            self.showingError = true
                        }
                    }
                }
            }
        } else {
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showingError = true
            } else {
                
                self.errorMessage = "Unknown error occurred."
                self.showingError = true
            }
        }
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
