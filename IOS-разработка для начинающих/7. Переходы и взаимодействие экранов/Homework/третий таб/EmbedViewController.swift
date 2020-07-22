import UIKit

protocol EmbedDelegateProtocol {
    func ColorMainBackground (_ ColorOutEmbed: UIColor?)
}

class EmbedViewController: UIViewController {
    
    var EmbedDelegator: EmbedDelegateProtocol?
    var EmbedColorBackground = UIColor.lightGray.cgColor
    
    @IBAction func ButtonEmbedYellow(_ sender: Any) {
        EmbedDelegator?.ColorMainBackground(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    }
    
    @IBAction func ButtonEmbedGreen(_ sender: Any) {
        EmbedDelegator?.ColorMainBackground(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))
    }
    
    @IBAction func ButtonEmbedPurple(_ sender: Any) {
        EmbedDelegator?.ColorMainBackground(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.backgroundColor = EmbedColorBackground
    }
}
// Skillbox
// Скиллбокс
