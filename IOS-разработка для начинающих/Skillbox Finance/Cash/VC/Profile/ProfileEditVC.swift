import UIKit
import RealmSwift

class ProfileEditVC: UIViewController {
    @IBOutlet weak var Photo: UIImageView!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Surname: UITextField!
    @IBOutlet weak var About: UITextView!
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    private let errorMsg = "Заполните это поле"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userinfo = self.realm.objects(UserInfo.self)
        self.Name.text = "\(userinfo.first!.name)"
        self.Surname.text = "\(userinfo.first!.surname)"
        self.About.text = "\(userinfo.first!.aboutme)"
    }
    
    @IBAction func Save(_ sender: Any) {
        if self.Name.text!.count > 0 && self.Surname.text!.count > 0 && self.About.text!.count > 0 {
        let userinfo = self.realm.objects(UserInfo.self)
        if let userinfo = userinfo.first {
        try! self.realm.write {
        userinfo.name = "\(self.Name.text!)"
        userinfo.surname = "\(self.Surname.text!)"
        userinfo.aboutme = "\(self.About.text!)"
                }
            }
        } else {
            self.Name.placeholder = self.errorMsg
            self.Surname.placeholder = self.errorMsg
            self.About.text = self.errorMsg
        }
    }
}
