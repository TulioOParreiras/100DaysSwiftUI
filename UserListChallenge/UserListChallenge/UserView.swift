//
//  UserView.swift
//  UserListChallenge
//
//  Created by Usemobile on 25/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct UserView: View {
    
    var user: User
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text(self.user.name + " (\(self.user.age))")
                    .font(.body)
                Text("-")
                    .font(.caption)
                Text(self.user.email)
                    .font(.caption)
                Spacer()
            }
            
            HStack {
                
                Text("Company: ")
                    .font(.subheadline)
                
                Text(self.user.company)
                    .font(.caption)
                
                Spacer()
            }
            
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(name: "Tulio", id: "123", isActive: true, age: 27, company: "Usemobile", email: "tulio@usemobile.xyz", address: "151, Professor Francisco Pignatario Street", about: "I'm an iOS developer who develops iOS applications", registered: "true story", tags: ["iOS", "HackingWithSwift"], friends: [Friend(id: "123456", name: "Gandalf")]))
    }
}
