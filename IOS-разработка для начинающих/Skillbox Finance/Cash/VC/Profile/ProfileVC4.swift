import UIKit
import RealmSwift
import Alamofire

class ProfileVC4: UIViewController {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Text: UITextView!
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userinfo = self.realm.objects(UserInfo.self)
        Name.text = "\(userinfo.first!.name)"
        fishtext(tf: self.Text)
    }
}
