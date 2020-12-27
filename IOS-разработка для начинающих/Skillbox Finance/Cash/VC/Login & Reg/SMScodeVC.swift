import UIKit
import RealmSwift

class SMScodeVC: UIViewController {
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    @IBOutlet weak var n1: UITextField!
    @IBOutlet weak var n2: UITextField!
    @IBOutlet weak var n3: UITextField!
    @IBOutlet weak var n4: UITextField!
    
    @IBOutlet weak var PhoneNumber: UILabel!
    @IBAction func SendAgain(_ sender: Any) {
        asyncAfter(0.25) { self.n4.text = nil
            asyncAfter(0.25) { self.n3.text = nil
                asyncAfter(0.25) { self.n2.text = nil
                    asyncAfter(0.25) { self.n1.text = nil
                        self.SmsGen() }}}}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhoneNumber.text = "Номер: \(self.realm.objects(UserInfo.self)[0].mobile)"
        SmsGen()
        self.view.addSubview(BackgroundVideo())
    }
    
    fileprivate func SmsGen() {
        asyncAfter(0.5) { SmsCode(TF: self.n1)
            asyncAfter(0.5) { SmsCode(TF: self.n2)
                asyncAfter(0.5) { SmsCode(TF: self.n3)
                    asyncAfter(0.5) { SmsCode(TF: self.n4)
                        asyncAfter(0.5) { self.ToEmailPage() }}}}}
    }
    
    func ToEmailPage() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmailVC")
        self.definesPresentationContext = true
        vc?.modalPresentationStyle = .overCurrentContext
        self.present(vc!, animated: true, completion: nil)
    }
}
