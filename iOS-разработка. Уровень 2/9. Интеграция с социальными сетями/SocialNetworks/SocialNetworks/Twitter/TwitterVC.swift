import UIKit
import TwitterKit
// Skillbox
// Скиллбокс
//https://cocoapods.org/pods/TwitterKit

class TwitterVC: UIViewController {
    
    @IBOutlet weak var LoginButton: UIButton!
    private let loginTwitter = TWTRLogInButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.LoginButton.setTitle(nil, for: .normal)
        DispatchQueue.main.async {
            self.loginTwitter.center = self.LoginButton.center
        }
        self.view.addSubview(loginTwitter)
    }
}
