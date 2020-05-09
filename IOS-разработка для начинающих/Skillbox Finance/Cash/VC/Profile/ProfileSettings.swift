import UIKit

class ProfileSettings: UIViewController {
    @IBOutlet weak var Background: UIImageView!
    @IBOutlet weak var Photo: UIImageView!
    @IBOutlet weak var LangLabel: UILabel!
    @IBOutlet weak var MetricsLabel: UILabel!
    @IBOutlet weak var NotiLabel: UILabel!
    
    @IBAction func Autoplay(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func Lang(_ sender: Any) {
    LangLabel.text = ["Русский", "English"].randomElement()
    }
    @IBAction func Metrics(_ sender: Any) {
    MetricsLabel.text = ["USD", "EUR", "RUR"].randomElement()
    }
    
    @IBAction func Noti(_ sender: Any) {
    NotiLabel.text = ["Часто", "Редко", "Никогда"].randomElement()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LangLabel.text = "Русский"
        MetricsLabel.text = "RUR"
        NotiLabel.text = "Никогда"
        Photo.layer.cornerRadius = Photo.frame.width / 2
    }
}
