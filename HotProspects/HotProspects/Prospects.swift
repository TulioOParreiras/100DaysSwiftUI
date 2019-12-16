//
//  Prospects.swift
//  HotProspects
//
//  Created by Usemobile on 16/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import Foundation

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        self.people = []
    }
}
