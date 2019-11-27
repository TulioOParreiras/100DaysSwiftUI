//
//  FriendEntity+CoreDataClass.swift
//  UserListChallenge
//
//  Created by Usemobile on 26/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

@objc(FriendEntity)
public class FriendEntity: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
    
    required public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "FriendEntity", in: managedObjectContext) else {
            fatalError("Failed to decode Friend")
        }
        super.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
    }
    
}
