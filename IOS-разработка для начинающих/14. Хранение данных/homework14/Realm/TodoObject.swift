import Foundation
import RealmSwift

class TodoObject: Object {
    @objc dynamic var date: String = "TodoObject: date"
    @objc dynamic var uuid: String = NSUUID().uuidString.lowercased()
    @objc dynamic var task: String = "TodoObject: task"
    @objc dynamic var isCompleted: Bool = false
    
    func uuiddata() -> String {
        let UUID = NSUUID().uuidString.lowercased()
        return UUID
    }
}
