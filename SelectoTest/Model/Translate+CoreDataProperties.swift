//
//  Translate+CoreDataProperties.swift
//  SelectoTest
//
//  Created by Sergiy Lyahovchuk on 30.08.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import Foundation
import CoreData


extension Translate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Translate> {
        return NSFetchRequest<Translate>(entityName: "Translate")
    }

    @NSManaged public var from: String?
    @NSManaged public var to: String?
    @NSManaged public var direction: String?
    @NSManaged public var created: NSDate?

}
