//
//  FriendEntity+CoreDataProperties.swift
//  UserListChallenge
//
//  Created by Usemobile on 26/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//
//

import Foundation
import CoreData


extension FriendEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendEntity> {
        return NSFetchRequest<FriendEntity>(entityName: "FriendEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    
}

