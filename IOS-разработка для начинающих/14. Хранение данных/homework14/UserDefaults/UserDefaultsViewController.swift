import UIKit

class UserDefaultsViewController: UIViewController {
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Surname: UITextField!
    @IBOutlet weak var GagView: UIView!
    @IBOutlet weak var Welcome: UILabel!
    @IBOutlet weak var RealmImage: UIImageView!
    @IBOutlet weak var CoreDataImage: UIImageView!
    @IBOutlet weak var RealmSection: UIButton!
    @IBOutlet weak var CoreDataSection: UIButton!
    
    @IBAction func NameEdit(_ sender: Any) {
        UserDataPersistance.sharing.NameData = Name.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    @IBAction func SurnameEdit(_ sender: Any) {
        UserDataPersistance.sharing.SurnameData = Surname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    @IBAction func NameCleaner(_ sender: Any) {
        (Name.text, Surname.text) = (nil, nil)
        UserDataPersistance.sharing.NameData = nil
        UserDataPersistance.sharing.SurnameData = nil
        transitionFlipFromTop(Name)
        transitionFlipFromBottom(Surname)
        Name.becomeFirstResponder() // фокус на поле Name
        Hello()
    }
    
    @IBAction func RealmTap(_ sender: Any) {
        disableAnimationImage()
    }
    
    @IBAction func CoreDataTap(_ sender: Any) {
        disableAnimationImage()
    }
    
    @IBAction func Exit(_ sender: Any) {
        exit(0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RealmSection.layer.zPosition = 1
        CoreDataSection.layer.zPosition = 1
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDataPersistance.sharing.NameData != nil {
            transitionFlipFromTop(Name)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.Name.text = UserDataPersistance.sharing.NameData
            }
        }
        if UserDataPersistance.sharing.SurnameData != nil {
            transitionFlipFromTop(Surname)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.Surname.text = UserDataPersistance.sharing.SurnameData
            }
        }
        Hello()
    }
}
