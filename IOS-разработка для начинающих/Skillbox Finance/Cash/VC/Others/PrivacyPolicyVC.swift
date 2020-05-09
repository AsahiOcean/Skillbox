import UIKit
import Alamofire

class PrivacyPolicyVC: UIViewController {

    @IBOutlet weak var TextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://fish-text.ru/get?format=html&number=10").response { response in
            if let data = response.data, let utf8 = String(data: data, encoding: .utf8) {
        self.TextView.text = utf8.components(separatedBy: ["<", ">", "p", "/"]).joined().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            }
        }
    }
}
