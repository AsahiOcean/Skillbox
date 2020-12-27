import UIKit

class AdsBanner: UIViewController {
    @IBOutlet weak var AdImage: UIImageView!
    
    let imgArray = ["321","123","234"] // какая-нибудь реклама
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.AdImage.image = UIImage(named:
                                            self.imgArray.randomElement()!)
            self.AdImage.isUserInteractionEnabled = true
            self.AdImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.TappedFunc)))
        }
    }
    @objc private func TappedFunc(_ recognizer: UITapGestureRecognizer) {
        print("Попались :)")
    }
}
