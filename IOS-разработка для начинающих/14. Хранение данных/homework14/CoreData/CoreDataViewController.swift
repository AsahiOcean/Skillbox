import UIKit
import CoreData
import SVProgressHUD
// Skillbox
// Скиллбокс

class CoreDataViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var AddButton: UIBarButtonItem!
    
    let CoreDataDB = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks = [Tasks]()
    
    @IBAction func AddButtonTouch(_ sender: Any) {
        AddButton.isEnabled = false // чтоб не хулиганить
        
        constraints = super.view.constraints.count
//        self.updateTime?.invalidate()
        
        let AddForm = ViewCoreDataForm.loadFromNIB()
        self.view.addSubview(AddForm)
        AddForm.TaskText.becomeFirstResponder()
        AddForm.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                AddForm.center = self.view.center
        })
        updaterStart()
    }
    
    func getData() { // создает запрос к бд
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            tasks = try context.fetch(Tasks.fetchRequest())
        }
        catch {
            print(error.localizedDescription)
        }
    }

// MARK: - Updater
    var updateTime: Timer?; var delay = 1.0; var constraints = 0
    
    @objc func updater(){
        /*
        такой костыль с constraints вроде работает неплохо, в идеале бы сравнивать количество элементов в базе данных до и после, а уже после этого обновлять таблицу
        */
        if constraints != super.view.constraints.count {
            getData(); tableView.reloadData();
//            print("UPD: \(Date())")
        } else {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.getData(); self.tableView.reloadData()
                self.AddButton.isEnabled = true
                self.updateTime?.invalidate()
                print("Обновление вроде остановилось")
//            }
        }
    }
    
    func updaterStart() {
//        print("Обновляю таблицу каждые \(delay) секунд(ы)")
        self.updateTime = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(self.updater), userInfo: nil, repeats: true) }

// MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SVProgressHUD.show(withStatus:"Обновляюсь...")
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: self.view.frame.width / 2, vertical: self.view.frame.height / 2))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.getData(); self.tableView.reloadData()
        }
        SVProgressHUD.dismiss(withDelay: 1.0)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.updateTime?.invalidate()
    }
}

// MARK: - extensions
extension CoreDataViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CoreDataCell
        let row = tasks[indexPath.row]
        cell.NameSurname.text = row.name
        cell.DateTime.text = "\(row.date!)"
        cell.TaskText.text = row.text
        return cell
    }
}
