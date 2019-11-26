//
//  ContentView.swift
//  UserListChallenge
//
//  Created by Usemobile on 25/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users: [User] = []
    
    let jsonURL = "https://www.hackingwithswift.com/samples/friendface.json"
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                List(users) { user in
                    NavigationLink(destination: UserDetailsView(user: user, userList: self.users)) {
                        UserView(user: user)
                    }
                }
            }
            .navigationBarTitle("Users List")
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: self.jsonURL) else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    self.users = try JSONDecoder().decode([User].self, from: data)
                } catch {
                    print("Decode error: ", error)
                }
            } else if let error = error {
                print("Request error: ", error)
            }
        }.resume()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
