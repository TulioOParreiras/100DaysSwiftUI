//
//  UserDetailsView.swift
//  UserListChallenge
//
//  Created by Usemobile on 26/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct UserDetailsView: View {
    
    var user: UserEntity
    var userList: [UserEntity]
    
    var body: some View {
        ScrollView {
            
            HStack {
                Text("Email: \(self.user.email)")
                .font(.caption)
                Spacer()
            }
            
            HStack {
                Text("Address: \(self.user.address)")
                .font(.caption)
                Spacer()
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                Text(self.user.about)
                .font(.body)
                Spacer()
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                Text("Tags: \(self.user.tags.joined(separator: ", "))")
                .font(.caption)
                Spacer()
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            
            Section {
                Text("Friends List")
                
                ForEach(0 ..< self.user.friendArray.count) { row in
                    NavigationLink(destination: UserDetailsView(user: self.getUser(for: row), userList: self.userList)) {
                        HStack {
                        Text(self.user.friendArray[row].name)
                        Spacer()
                        }
                    }
//                    NavigationLink(destination: UserDetailsView(user: self.userList.first(where: { $0 == self.user.friends[row] })!), userList: self.userList) {
//
//                    }
                }
//                List(self.user.friends) { friend in
//                    Text(friend.name)
//                }
            }
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
            
            
            
//            Spacer()
        }
        .padding(16)
        .navigationBarTitle(self.user.name + " (\(self.user.age))")
    }
    
    func getUser(for row: Int) -> UserEntity {
        return self.userList.first(where: { $0.id == self.user.friendArray[row].id})!
    }
    
}
