//
//  RealmViewController.swift
//  homework14
//
//  Created by Serg Fedotov on 11.04.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import UIKit
import RealmSwift

class RealmViewController: UIViewController {
        
        private let realm = try! Realm()
        var todo: Results<TodoObject>!
        
        @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var AddTaskButton: UIButton!
        
        @IBAction func AddTaskButtonTouch(_ sender: Any) {
            self.updateTime?.invalidate() // чтобы не дублировать таймер
    //        print("Возможно будет создана задача...")
            let AddForm = AddFormConfig.loadFromNIB()
                self.view.addSubview(AddForm)
            let hash = AddForm.hash
                if hash != 0 {
                    print("Создан UIView #\(hash)") // для справки :)
                }
            AddForm.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                AddForm.center = self.view.center
            })
            AddForm.Task.becomeFirstResponder() // фокус на поле ввода
            updaterStart()
        }

    // MARK: - Updater
        var updateTime: Timer?
        var delay = 1.0 // делэй в секундах

        @objc func updater(){
            self.tableView.reloadData() // перезагружает tableView
        }
        /*
        Оставил так, потому что вью (AddFormConfig) созданый из этого контроллера не может здесь остановить таймер - выводит фатал тред (от 1 до 10), как только я не пытался экспериментировать с DispatchQueue. Видно что-то делал не так, либо не то.
         
         p.s. При этом вью после нажатия внутри него кнопки может уничтожиться и вызвать здесь функцию, например с принтом.
        */
        func updaterStart() {
    //        print("Обновление таблицы каждые: \(delay) секунд\n")
            self.updateTime = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(self.updater), userInfo: nil, repeats: true)
        }

    // MARK: - override
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            self.updateTime?.invalidate() // убивает таймер
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.todo = RealmClass.shared.getTasks()
        }
    }

    // MARK: - extension
    extension RealmViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if todo.count != 0 {
                return todo.count
            } else {
                return 0
            }}
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RealmCell") as! RealmCell
            let row = self.todo[indexPath.row]
            cell.DateTime.text = row.date
            cell.TaskText.text = row.task
            return cell
        }
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completion in
                RealmClass.shared.remove(todo: self.todo[indexPath.row])
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [action])
        }
    }
