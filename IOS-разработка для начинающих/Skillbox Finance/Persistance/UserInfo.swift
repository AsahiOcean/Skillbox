import Foundation
import RealmSwift

class UserInfo: Object {
    @objc dynamic var name: String = "Иван"
    @objc dynamic var surname: String = "Иванов"
    @objc dynamic var aboutme: String = ""
    @objc dynamic var mobile: String = ""
    @objc dynamic var login: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var pass: String = ""
    @objc dynamic var ImageData = Data()
    @objc dynamic var facebook = Bool()
    @objc dynamic var notifications = Bool()
    @objc dynamic var followers = 0
    @objc dynamic var pourboire = 0
    @objc dynamic var money = 30000
    @objc dynamic var portacheno = 0
    @objc dynamic var orders = 0
}
