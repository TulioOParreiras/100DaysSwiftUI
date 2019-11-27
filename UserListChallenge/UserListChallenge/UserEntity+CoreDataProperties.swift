//
//  UserEntity+CoreDataProperties.swift
//  UserListChallenge
//
//  Created by Usemobile on 26/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String
    @NSManaged public var age: Int16
    @NSManaged public var company: String
    @NSManaged public var email: String
    @NSManaged public var address: String
    @NSManaged public var about: String
    @NSManaged public var registered: String
    @NSManaged public var tags: [String]
    @NSManaged public var friends: NSSet?
    
    var friendArray: [FriendEntity] {
        let set = friends  as? Set<FriendEntity> ?? []
        
        return set.sorted {
            $0.name < $1.name
        }
    }

}

// MARK: Generated accessors for friends
extension UserEntity {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: FriendEntity)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: FriendEntity)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}
