//
//  User.swift
//  UserListChallenge
//
//  Created by Usemobile on 25/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable {
    let name: String
    let id: String
    let isActive: Bool
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}
