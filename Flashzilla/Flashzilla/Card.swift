//
//  Card.swift
//  Flashzilla
//
//  Created by Usemobile on 08/01/20.
//  Copyright © 2020 Usemobile. All rights reserved.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String

    static var example: Card {
        return Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
