//
//  ContentView.swift
//  UserListChallenge
//
//  Created by Usemobile on 25/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import CoreData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: UserEntity.entity(), sortDescriptors: []) var userEntities: FetchedResults<UserEntity>
    
    @State private var users: [UserEntity] = []
    
    let jsonURL = "https://www.hackingwithswift.com/samples/friendface.json"
    
    var body: some View {
        
        NavigationView {
            VStack {
                List(self.users, id: \.id) { user in
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
//        self.userEntities.forEach({
//            self.moc.delete($0)
//
//        })
//        try? self.moc.save()

         guard self.userEntities.isEmpty else {
            self.users = self.userEntities.compactMap({ $0 })
            return
         }
         print("USER ENTITIES EMPTY")
         
        guard let url = URL(string: self.jsonURL) else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.userInfo[CodingUserInfoKey.context!] = self.moc
                    self.users = try decoder.decode([UserEntity].self, from: data)
                    try? self.moc.save()
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
