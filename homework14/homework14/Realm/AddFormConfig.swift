//
//  AddFormConfig.swift
//  homework14
//
//  Created by Serg Fedotov on 11.04.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import UIKit
import RealmSwift

class AddFormConfig: UIView {
    
    fileprivate let realm = try! Realm()
    fileprivate let general = RealmViewController()
    fileprivate let todoinfo = TodoObject()
    let name = UserDataPersistance.sharing.NameData
    let surname = UserDataPersistance.sharing.SurnameData
            
    @IBOutlet weak var Task: UITextView!
    @IBOutlet weak var Cancel: UIButton!
    @IBOutlet weak var Add: UIButton!
    
    @IBAction func AddTouch(_ sender: Any) {
        RealmClass.shared.add(tasktext: self.Task.text)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.center.y -= UIScreen.main.bounds.height
            }, completion: { _ in
                super.removeFromSuperview() // удаляем view
            })
        let rc = RealmClass()
        print("UIID: \(self.todoinfo.uuid)") // на всякий случай :)
        print("Дата и время: \(rc.DateString())")
        print("Пользователь: \(username())")
        if self.Task.text.count > 0 {
            print("Текст: \(self.Task.text!)")
        } else {
            print("Текст: *пусто*")
        }
        print("- - - - - - - - - - - - - - - - -")
    }
    
    @IBAction func CancelTouch(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.center.y += UIScreen.main.bounds.height
            }, completion: { _ in
                super.removeFromSuperview()
        })
        
        let rc = RealmClass()
        print("UIID: \(self.todoinfo.uuid)")
        print("Дата и время: \(rc.DateString())")
        print("Пользователь: \(username())")
        print("ОТМЕНА МИССИИ!")
        print("- - - - - - - - - - - - - - - - -")
    }
    
    static func loadFromNIB() -> AddFormConfig {
            let nib = UINib(nibName: "AddForm", bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as! AddFormConfig
    }
    
    func username() -> String {
        if ((name?.isEmpty) == nil) && ((surname?.isEmpty) == nil) {
            return "anonymous"
        } else if ((name?.isEmpty) != nil) && ((surname?.isEmpty) == nil) {
            return "\(name!)"
        } else if ((name?.isEmpty) == nil) && ((surname?.isEmpty) != nil) {
            return "\(surname!)"
        } else {
            return "\(name!) \(surname!)"
        }
    }
}
