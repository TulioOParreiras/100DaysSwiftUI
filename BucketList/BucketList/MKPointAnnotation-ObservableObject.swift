//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Usemobile on 09/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }
        
        set {
            self.title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }
        
        set {
            self.subtitle = newValue
        }
    }
    
}
