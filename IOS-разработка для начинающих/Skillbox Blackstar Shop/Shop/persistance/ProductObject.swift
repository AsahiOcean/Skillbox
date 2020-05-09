//
//  ProductObject.swift
//  Shop
//
//  Created by Serg Fedotov on 01.05.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import Foundation
import RealmSwift

class ProductObject: Object{
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var colorName: String = ""
    @objc dynamic var mainImageLink: String = ""
    @objc dynamic var size: String = ""
    @objc dynamic var price: String = ""
    
    func getData(id: String, name: String, colorName: String, mainImageLink: String, price: String, size: String) {
        self.id = id
        self.name = name
        self.colorName = colorName
        self.mainImageLink = mainImageLink
        self.price = price
        self.size = size
    }
}
