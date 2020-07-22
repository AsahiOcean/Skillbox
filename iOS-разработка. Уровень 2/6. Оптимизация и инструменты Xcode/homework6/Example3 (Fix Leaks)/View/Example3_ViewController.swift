import UIKit
// Skillbox
// Скиллбокс

public var refCount3 = 0 {
    didSet {
        if refCount3 > 1 {
            print("*** Example_3 УТЕЧЕК: \(refCount3 - 1) ***")
        }
    }
}

class Example3_ViewController: UIViewController, ToDoViewProtocol {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todo: UITextField!
    
    var presenter: ToDoPresenterProtocol?
    private var todoList = [String()]
    
    func showMe(_ todolist: [String]) {
        self.todoList = todolist
        self.tableView.reloadData()
    }
    
    @IBAction func ToDoAdd(_ sender: UIButton) {
        if todo.text != "" {
            if let todo = self.todo.text {
                self.presenter?.add(todo)
                self.todo.text = ""
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(">> Example3 добавлен в память")
        refCount3 += 1
        ToDoRouter.controller(self)
        self.presenter?.get()
    }
    
    let alert = UIAlertController(title:"МИНУТОЧКУ!", message: "VIPER может вызвать\n потенциальные утечки памяти,\nя решил эту проблему\n использованием 'unowned' \nв некоторых местах :)", preferredStyle: .alert)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    deinit { print("<<< Example3 удален из памяти!"); refCount3 -= 1 }
}
extension Example3_ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = "\(self.todoList[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("\(indexPath.row). \(self.todoList[indexPath.row])")
        self.presenter?.remove(indexPath.row)
        self.tableView.reloadData()
    }
}
