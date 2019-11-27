//
//  UserView.swift
//  UserListChallenge
//
//  Created by Usemobile on 25/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct UserView: View {
    
    var user: UserEntity
    
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
