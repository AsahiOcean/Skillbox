import UIKit
import Alamofire

class InfoRatingVC: UIViewController {
    
    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var Text1: UITextView!
    
    @IBOutlet weak var Image2: UIImageView!
    @IBOutlet weak var Text2: UITextView!
    
    @IBOutlet weak var Image3: UIImageView!
    @IBOutlet weak var Text3: UITextView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        fishtext(tf: self.Text1)
        fishtext(tf: self.Text2)
        fishtext(tf: self.Text3)
    }
}
