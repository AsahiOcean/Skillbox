import UIKit
import Bond
// Skillbox
// Скиллбокс

/*
хватит для большинства программ:
map
filter
combineLatest
*/

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var greetButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addCell(_ sender: Any) {
        names.append("New cell")
    }
    
    let names = MutableObservableArray(["1","2","3","4","5"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        names.bind(to: tableView) { (dataSource, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
            cell.namelabel.text = dataSource[indexPath.row]
            return cell
        }
        
// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        let name = Observable<String?>("1")
        let age = Observable(25)

        let greeting = Observable("")
        name.ignoreNils()
            .with(latestFrom: age)
            .map{ "Hello, \($0) \($1)"}
            .bind(to: greeting)
        
// обнаружит нажатие и передаст значение
        greetButton.reactive.tap.observeNext{
            self.greetingLabel.text = self.nameTextField.text
        }
//        nameTextField.reactive.text.ignoreNils()
//            .map { $0.isEmpty ? "" : "Hello, \($0)" }
//            .bind(to: greetingLabel.reactive.text)
// выводит предыдущее имя
//        name.ignoreNils().zipPrevious().observeNext{(previousName, name) in
//            print("\(previousName ?? "noname")", "\(name)")
//        }
// - - - - - - - - - - - - - - - - - - - - -
// Задержка перед отправкой информации
//      name.ignoreNils().filter {$0.count > 3}
//          .throttle(for: 0.3) // задержка
//          .observeNext { name in
//          print("qweqwe")
//      }
//  либо
//      name.debounce(for: 1)

// - - - - - - - - - - - - - - - - - - - - -
//        let isButtonEnable = Observable(false)
//        name.ignoreNils().filter{ $0.count > 5 }.replaceElements(with: true).bind(to: isButtonEnable)

// - - - - - - - - - - - - - - - - - - - - -
// Когда возвращаемое значение опционально и его нужно отфильтровать
//      name.compactMap{ $0 }.map{ "Hello, \($0)"}.bind(to: greeting)

// - - - - - - - - - - - - - - - - - - - - -
// Для вывода двух значений (name + age)
//      name.ignoreNils().combineLatest(with: age)
//          .map { "Hello, \($0) \($1)" }
//          .bind(to: greeting)
        
// - - - - - - - - - - - - - - - - - - - - -
// Вывод только от двух значений
//      name.buffer(size: 2)
//          .map { "Hello, \($0)" }
//          .bind(to: greeting)
        
        greeting.observeNext { name in print(name) }
        
        name.value = "2"
        name.value = nil
        age.value = 24
        
        name.value = "3"
    }
}
