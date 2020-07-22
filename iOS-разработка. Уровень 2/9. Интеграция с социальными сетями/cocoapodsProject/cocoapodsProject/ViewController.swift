import UIKit
import Alamofire
// Skillbox
// Скиллбокс

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://fish-text.ru/get?format=html&number=1").responseString(completionHandler: { response in
            print(response.value!)
        })
    }
}
