import UIKit
import RealmSwift
import Alamofire

class ProfileVC2: UIViewController {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Surname: UILabel!
    @IBOutlet weak var Name2: UILabel!
    @IBOutlet weak var Surname2: UILabel!
    @IBOutlet weak var ProfilePhoto: UIImageView!
    @IBOutlet weak var Subscriptions: UILabel!
    @IBOutlet weak var Followers: UILabel!
    @IBOutlet weak var Text1: UITextView!
    @IBOutlet weak var Text2: UITextView!
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userinfo = self.realm.objects(UserInfo.self)
        // у фотки
        self.Name.text = "\(userinfo.first!.name)"
        self.Surname.text = "\(userinfo.first!.surname)"
        // по середине страницы
        self.Name2.text = "\(userinfo.first!.name)"
        self.Surname2.text = "\(userinfo.first!.surname)"
        self.Followers.text = "\(userinfo.first!.followers)"
        
        fishtext(tf: self.Text1); fishtext(tf: self.Text2)
        
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { _ in
            let followers = Int(self.Followers.text!)
            self.Followers.text = String(followers! + Int.random(in: 1..<100))
            if Int(self.Followers.text!)! > 99999 {
                self.Followers.text = "99999"
            }}
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        let userinfo = self.realm.objects(UserInfo.self)
        if let userinfo = userinfo.first {
            try! self.realm.write {
                userinfo.followers = Int(self.Followers.text!)!
            }}; print(userinfo)
    }
}
