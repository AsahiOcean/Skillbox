//
//  Category.swift
//  Shop
//
//  Created by Serg Fedotov on 01.05.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import Foundation
import UIKit

struct Category {
    let id: String
    let name: String
    let imageLink: String
    let sortOrder: String
    let subcategories: [Category]?
    var image: UIImage?
}
