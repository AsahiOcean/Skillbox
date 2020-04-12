//
//  Tasks+CoreDataProperties.swift
//  
//
//  Created by Serg Fedotov on 12.04.2020.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var date: String?
    @NSManaged public var name: String?
    @NSManaged public var text: String?

}
