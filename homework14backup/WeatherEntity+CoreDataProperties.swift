//
//  WeatherEntity+CoreDataProperties.swift
//  
//
//  Created by Serg Fedotov on 12.04.2020.
//
//

import Foundation
import CoreData


extension WeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntity> {
        return NSFetchRequest<WeatherEntity>(entityName: "WeatherEntity")
    }

    @NSManaged public var weatherdata: Data?

}
