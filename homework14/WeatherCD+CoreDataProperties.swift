//
//  WeatherCD+CoreDataProperties.swift
//  
//
//  Created by Serg Fedotov on 12.04.2020.
//
//

import Foundation
import CoreData


extension WeatherCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherCD> {
        return NSFetchRequest<WeatherCD>(entityName: "WeatherCD")
    }

    @NSManaged public var json: Data?

}
