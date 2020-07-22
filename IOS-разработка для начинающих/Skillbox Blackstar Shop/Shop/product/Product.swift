import Foundation
import UIKit
// Skillbox
// Скиллбокс

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
