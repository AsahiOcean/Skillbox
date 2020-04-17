import UIKit

struct Category {
    var CategoryNames = ""
    var CellsSettings: [String] = []
}

class SettingsTable {
    static func Cell() -> [Category]{
        return [
            Category(CategoryNames: " ", CellsSettings: ["Авиарежим", "Wi-Fi", "Bluetooth", "Сотовая связь", "Режим модема"]),
            Category(CategoryNames: " ", CellsSettings: ["Уведомления", "Звуки, тактильные сигналы", "Не беспокоить", "Экранное время"]),
            Category(CategoryNames: " ", CellsSettings: ["Основные", "Пункт управления", "Экран и яркость"]),
        ]
    }
}

class ViewController2: UIViewController {

    var Cell = SettingsTable.Cell()

    @IBOutlet weak var SettingsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController2: UITableViewDataSource, UITableViewDelegate {
// Количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return Cell.count
    }
// Количетсво ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cell[section].CellsSettings.count
    }
// Заголовок секции
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Cell[section].CategoryNames
    }
    
// Как выглядит ячейка
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsTableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        let name = Cell[indexPath.section].CellsSettings[indexPath.row]
        if name == "Авиарежим" {
            cell.Switch.isHidden = false
        } else {
            cell.Switch.isHidden = true
            cell.accessoryType = .disclosureIndicator
        }
        cell.IconImage.image = UIImage(named: "\(name)")
        cell.nameLabel.text = name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SettingsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
}
