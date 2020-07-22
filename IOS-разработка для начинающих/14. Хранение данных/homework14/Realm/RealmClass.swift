import Foundation
import RealmSwift
// Skillbox
// Скиллбокс

class RealmClass {
    
    static let shared = RealmClass()
    private let realm = try! Realm()
    
    func getTasks() -> Results<TodoObject> {
        return realm.objects(TodoObject.self) // возвращает все объекты
    }

    func add(tasktext: String) {
        let item = TodoObject()
        try! realm.write {
            realm.add(item)
            item.date = DateString() // привязываем дату
            item.task = tasktext // передаем текст
        }
        realm.refresh()
    }
    
    func remove(todo: TodoObject) {
        try! realm.write {
            realm.delete(todo)
        }
    }

// MARK: - Date to String
    func DateString() -> String {
        let (rawDate, dateFormatter) = (Date(), DateFormatter())
        dateFormatter.dateFormat = "dd.MM.YY HH:mm:ss"
        let DateString = dateFormatter.string(from: rawDate)
        return DateString
    }
}
