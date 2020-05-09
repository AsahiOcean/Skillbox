//
//  Product.swift
//  Shop
//
//  Created by Serg Fedotov on 01.05.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import Foundation
import UIKit

struct Product {
    let id: String
    let name: String
    let sortOrder: String
    let article: String
    let collection: String?
    var description: String
    let colorName: String
    let mainImageLink: String
    let arrayImageLinks: [String]?
    let price: String
    var mainImage: UIImage? = nil
    var gallery: [UIImage?] = []
    var offers: [[String : String]]?
    let productAttributes: [[String : String]]
}
