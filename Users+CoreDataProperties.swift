//
//  Users+CoreDataProperties.swift
//  GameRecords
//
//  Created by Shun-Ching, Chou on 2017/6/8.
//  Copyright © 2017年 Shun-Ching, Chou. All rights reserved.
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var emailVerified: Bool

}
