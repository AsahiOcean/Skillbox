import UIKit
import RealmSwift

class ProfileStatVC: UIViewController {
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Surname: UILabel!
    @IBOutlet weak var Followers: UILabel!
    @IBOutlet weak var Money: UILabel!
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    var timer: Timer?
    var pourboire = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Followers.text = "0"
        Money.text = "0"
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        let userinfo = self.realm.objects(UserInfo.self)
        Name.text = "\(userinfo.first!.name)"
        Surname.text = "\(userinfo.first!.surname)"
    }
    
    @objc func timerFunc() {
        PlusFollowers()
        PlusMoney()
        
        let userinfo = self.realm.objects(UserInfo.self)
        if Int(self.Followers.text!)! >= userinfo.first!.followers {
            self.Followers.text = String(userinfo.first!.followers)
        }
        
        if Int(self.Money.text!)! >= userinfo.first!.money {
            self.Money.text = String(userinfo.first!.money)
        }
    }
    
    private func PlusFollowers() {
        let followers = Int(self.Followers.text!)
        self.Followers.text = String(followers! + Int.random(in: 1..<333))
    }
    
    private func PlusMoney() {
        let money = Int(self.Money.text!)
        self.Money.text = String(money! + Int.random(in: 1000..<3333))
    }
}
