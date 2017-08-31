//
//  Translate+CoreDataClass.swift
//  SelectoTest
//
//  Created by Sergiy Lyahovchuk on 30.08.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import Foundation
import CoreData

@objc(Translate)
public class Translate: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
