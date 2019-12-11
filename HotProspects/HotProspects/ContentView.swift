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

struct ContentView: View {
    
    let user = User()
    
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {

                Text("Tab 1")
                    .onTapGesture {
                        self.selectedTab = 1
                }
                    .tabItem {
                        Image(systemName: "star")
                        Text("One")
                    }

            Text("Tab 2")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Two")
                }
            .tag(1)
        }
        
//
//        VStack {
//            EditView()
//            DisplayView()
//        }
//        .environmentObject(user)
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
