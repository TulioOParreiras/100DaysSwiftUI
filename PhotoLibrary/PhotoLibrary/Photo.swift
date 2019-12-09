//
//  Photo.swift
//  PhotoLibrary
//
//  Created by Usemobile on 09/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit
import SwiftUI

struct Photo: Codable, Identifiable, Comparable {
    let name: String
    let data: Data
    let id = UUID()
    
    var image: UIImage {
        UIImage(data: self.data) ?? UIImage()
    }
    
    static func < (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.name < rhs.name
    }
}
