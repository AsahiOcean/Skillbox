import UIKit
import RealmSwift
import Alamofire

class ProfileWalletsVC: UIViewController {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Surname: UILabel!
    @IBOutlet weak var USD: UILabel!
    @IBOutlet weak var EUR: UILabel!
    @IBOutlet weak var RUR: UILabel!
    @IBOutlet weak var Text: UITextView!
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!

    override func viewDidLoad() {
        super.viewDidLoad()
        (self.USD.text,self.EUR.text,self.RUR.text) = ("0","0","0")
        let userinfo = self.realm.objects(UserInfo.self)
        self.Name.text = "\(userinfo.first!.name)"
        self.Surname.text = "\(userinfo.first!.surname)"
        fishtext(tf: self.Text)
        
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true)
        { _ in
        let rand = Int.random(in: 100..<333)
        self.USD.text = String(Int(self.USD.text!)! + rand)
        self.EUR.text = String(Int(self.EUR.text!)! + rand)
        self.RUR.text = String(Int(self.RUR.text!)! + (rand*10))
        if Int(self.USD.text!)! >= 1111 { self.USD.text = "1111"}
        if Int(self.EUR.text!)! >= 1111 { self.EUR.text = "1111"}
        
        let userinfo = self.realm.objects(UserInfo.self)
        if let userinfo = userinfo.first {
            if Int(self.RUR.text!)! >= userinfo.money { self.RUR.text = String(userinfo.money)}
        }
    }
}
}
