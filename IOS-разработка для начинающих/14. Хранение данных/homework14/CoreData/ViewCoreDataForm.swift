import UIKit
import CoreData
import Alamofire
import SVProgressHUD

class ViewCoreDataForm: UIView {
    
    let CoreDataDB = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    fileprivate let general = CoreDataViewController()
    fileprivate let name = UserDataPersistance.sharing.NameData
    fileprivate let surname = UserDataPersistance.sharing.SurnameData
    
    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet weak var NoButton: UIButton!
    @IBOutlet weak var Assistant: UIButton!
    @IBOutlet weak var TaskText: UITextView!
    
    // MARK: - Buttons
    
    @IBAction func YesTap(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = Tasks(context: context)
        task.name = username()
        task.date = date()
        task.text = TaskText.text
        
        // передать присвоенные значения
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        print("- - - - - - - - - - - - - - - - - - - - - ")
        print("Время: \(date())")
        print("UUID: \(NSUUID().uuidString.lowercased())")
        print("Пользователь: \(self.username())")
        print("\(self.TaskText.text ?? "* ПУСТО *")")
        print("- - - - - - - - - - - - - - - - - - - - - ")
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            super.alpha = 0
            super.center.y -= UIScreen.main.bounds.height
        }, completion: { _ in
            super.removeFromSuperview()
        })
    }
    
    @IBAction func NoTap(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            super.alpha = 0
            super.center.y += UIScreen.main.bounds.height
        }, completion: { _ in
            super.removeFromSuperview()
            print("Порадуйте новостями...")
        })
    }
    
    @IBAction func FishTextGen(_ sender: Any) {
        SVProgressHUD.show(withStatus:"Придумываю...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.TextGenerator()
        }
        SVProgressHUD.dismiss(withDelay: 1.0)
    }
    
    // MARK: - loadFromNIB
    static func loadFromNIB() -> ViewCoreDataForm {
        let nib = UINib(nibName: "AddFormCoreData", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! ViewCoreDataForm
    }
    
    // MARK: - username check
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
    // MARK: - Date
    func date() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: (TimeZone.current.abbreviation() ?? "GMT"))
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm:ss"
        let strTime = dateFormatter.string(from: date)
        return strTime
    }
    
    // MARK: - TextGenerator
    func TextGenerator() {
        AF.request("https://fish-text.ru/get?format=html&number=2").response { response in
            if let data = response.data, let utf8 = String(data: data, encoding: .utf8) {
                self.TaskText.text = utf8.components(separatedBy: ["<", ">", "p", "/"]).joined().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            } else {
                SVProgressHUD.showError(withStatus: "Помните...")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.TaskText.textAlignment = .center
                    self.TaskText.font = .systemFont(ofSize: 22)
                    self.TaskText.text = "«У всего есть чудеса свои чудеса, даже у темноты и тишины - учитесь быть довольными независимо от того, где находитесь».\n\nХелен Адамс Келлер."
                }
                SVProgressHUD.dismiss(withDelay: 1.0)
            }
        }
    }
}
