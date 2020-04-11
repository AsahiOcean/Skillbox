//
//  TodoObject.swift
//  homework14
//
//  Created by Serg Fedotov on 11.04.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

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
