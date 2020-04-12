//
//  RealmClass.swift
//  homework14
//
//  Created by Serg Fedotov on 11.04.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import Foundation
import RealmSwift

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
