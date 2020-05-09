import Foundation
import UIKit

fileprivate let image = UIImage(named: "pokemon")

struct ItemsProvider {
    static func get() -> [Items] {
        return [
            Items(name: "Item 1", img: image!),
            Items(name: "Item 2", img: image!),
            Items(name: "Item 3", img: image!),
            Items(name: "Item 4", img: image!),
            Items(name: "Item 5", img: image!),
            Items(name: "Item 6", img: image!),
            Items(name: "Item 7", img: image!),
            Items(name: "Item 8", img: image!),
            Items(name: "Item 9", img: image!),
            Items(name: "Item 10", img: image!),
            Items(name: "Item 11", img: image!),
            Items(name: "Item 12", img: image!)
        ]
    }
}
