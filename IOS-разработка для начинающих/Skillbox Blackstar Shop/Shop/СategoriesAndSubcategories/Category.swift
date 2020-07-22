import Foundation
import UIKit
// Skillbox
// Скиллбокс

struct Category {
    let id: String
    let name: String
    let imageLink: String
    let sortOrder: String
    let subcategories: [Category]?
    var image: UIImage?
}
