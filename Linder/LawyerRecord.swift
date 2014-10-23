//
//  LawyerRecord.swift
//  Linder
//
//  Created by Jeffrey Ching on 10/22/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import Foundation
import CoreData

class LawyerRecord: NSManagedObject {

    @NSManaged var averageReviewScore: NSNumber
    @NSManaged var headshotUrl: String
    @NSManaged var id: NSNumber
    @NSManaged var liked: NSNumber
    @NSManaged var name: String
    @NSManaged var rating: NSNumber

}
