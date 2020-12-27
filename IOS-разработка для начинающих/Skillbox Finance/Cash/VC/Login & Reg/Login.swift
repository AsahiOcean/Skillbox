import UIKit
import RealmSwift

class Login: UIViewController {
    
    @IBOutlet weak var Mobile: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var Indicator: UIActivityIndicatorView!
    @IBAction func RadioButton(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected { LoginButton.isEnabled = true }
    }
    @IBAction func LoginButtonTouch(_ sender: Any) { self.GoToSMSvc()
    }
    
    private let realm = try! Realm()
    private var resul: Results<UserInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userinfo = self.realm.objects(UserInfo.self)
        if userinfo.isEmpty { self.AutoReg()
        } else { self.AutoLogin() }
        LoginButton.layer.cornerRadius = 10
        self.view.addSubview(BackgroundVideo())
    }
    
    fileprivate func AutoReg() {
        Persistance().add(info: "userinfo")
        let userinfo = self.realm.objects(UserInfo.self)
        MobileNumberGen(TF: self.Mobile); buttonActive()
        asyncAfter(2.0) {
            if let userinfo = userinfo.first {
                try! self.realm.write {
                    userinfo.mobile = "\(self.Mobile.text!)"
                    userinfo.login = "\(self.Mobile.text!)"
                }
            }
            print("Mobile: \(userinfo.first!.mobile)")
            print("Login: \(userinfo.first!.login)")
        }
    }
    
    fileprivate func AutoLogin() {
        Mobile.placeholder = "Загружаю данные..."
        Indicator.isHidden = false
        let userinfo = self.realm.objects(UserInfo.self)
        asyncAfter(1.0) {
            self.Mobile.text = "\(userinfo.first!.mobile)"
            self.buttonActive() }
    }
    
    fileprivate func buttonActive() {
        asyncAfter(1.5) { self.LoginButton.alpha = 1.0
            asyncAfter(0.5) { self.GoToSMSvc() }}
    }
    
    fileprivate func GoToSMSvc() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SMScodeVC")
        self.definesPresentationContext = true
        vc?.modalPresentationStyle = .overCurrentContext
        self.present(vc!, animated: true, completion: nil)
    }
}
