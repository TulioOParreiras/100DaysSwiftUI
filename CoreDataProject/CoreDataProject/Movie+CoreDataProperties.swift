//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Usemobile on 25/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var year: Int16
    @NSManaged public var title: String?
    @NSManaged public var director: String?

    public var wrappedTitle: String {
        return self.title ?? "Unknown title"
    }
    
}
