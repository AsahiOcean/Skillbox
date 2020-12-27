import UIKit
import RealmSwift
import UserNotifications

class ProfileNotificationsVC: UIViewController {
    
    @IBOutlet weak var Yes: UIButton!
    @IBOutlet weak var No: UIButton!
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    
    @IBAction func YesTap(_ sender: Any) {
        let userinfo = self.realm.objects(UserInfo.self)
        if let userinfo = userinfo.first {
            try! self.realm.write {
                userinfo.notifications = true
            }
        }
        registerForPushNotifications()
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Уведомления разрешены?: \(granted) \n")
            guard granted else { return }
        }
    }
    
    
    @IBAction func NoTap(_ sender: Any) {
        let userinfo = self.realm.objects(UserInfo.self)
        if let userinfo = userinfo.first {
            try! self.realm.write {
                userinfo.notifications = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Yes.layer.cornerRadius = self.Yes.frame.width / 2
        self.No.layer.cornerRadius = self.No.frame.width / 2
    }
}
