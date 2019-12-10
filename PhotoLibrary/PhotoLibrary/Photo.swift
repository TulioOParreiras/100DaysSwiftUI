//
//  Photo.swift
//  PhotoLibrary
//
//  Created by Usemobile on 09/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import CoreLocation
import UIKit
import SwiftUI

struct Photo: Codable, Identifiable, Comparable {
    let name: String
    let data: Data
    let id = UUID()
    private let latitude: Double?
    private let longitude: Double?
    
    var location: CLLocationCoordinate2D? {
        guard let latitude = self.latitude, let longitude = self.longitude else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
    init(name: String, data: Data, latitude: Double, longitude: Double) {
        self.name = name
        self.data = data
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var image: UIImage {
        UIImage(data: self.data) ?? UIImage()
    }
    
    static func < (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.name < rhs.name
    }
}
