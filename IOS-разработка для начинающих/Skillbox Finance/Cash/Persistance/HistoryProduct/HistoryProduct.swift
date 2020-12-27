import Foundation
import RealmSwift

class HistoryProduct: Object {
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
