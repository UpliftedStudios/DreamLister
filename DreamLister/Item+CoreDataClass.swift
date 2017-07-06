//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by marcus hidalgo on 7/5/17.
//  Copyright © 2017 Uplifted Studios. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        
        super.awakeFromInsert()
        
        self.created = NSDate()
        
    }

}
