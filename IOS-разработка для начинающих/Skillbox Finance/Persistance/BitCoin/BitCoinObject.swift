import Foundation
import RealmSwift

// When = Date(), USD = Int(), EUR = Int(), RUB = Int()
class BitCoinObject: Object {
    @objc dynamic var When = Date()
    @objc dynamic var USD = Int()
    @objc dynamic var EUR = Int()
    @objc dynamic var RUB = Int()
}
