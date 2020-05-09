import UIKit
import RealmSwift

class MoneyNotif: UIViewController {
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet var backbround: UIView!
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!

    override func viewDidLoad() {
        super.viewDidLoad()
        let userinfo = self.realm.objects(UserInfo.self)
        cost.text = "\(userinfo.first!.portacheno)"
        balance.text = "\(userinfo.first!.money - userinfo.first!.portacheno)"
        if let userinfo = userinfo.first {
            try! self.realm.write {
            userinfo.money = Int(balance.text!)!
        }}
        backbround.layer.cornerRadius = 20
        asyncAfter(2.0) { self.view.removeFromSuperview() }
    }
}
