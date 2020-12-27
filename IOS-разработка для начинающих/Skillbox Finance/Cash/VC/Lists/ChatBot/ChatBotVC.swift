import UIKit
import RealmSwift

class ChatBotVC: UIViewController {
    
    @IBOutlet weak var NavigationBarTitle: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarTitle.topItem?.title = "\(MobileNumberGenString())"
    }
}
