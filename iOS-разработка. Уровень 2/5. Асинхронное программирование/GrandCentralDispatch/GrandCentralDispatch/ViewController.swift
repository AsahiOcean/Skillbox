import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var time: UILabel!
    
    var timer: Timer? = Timer()
    var counter: Float = 0.00 {
    didSet { time.text = String(format: "%.2f", counter) }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector: #selector(self.UpdateTimer), userInfo: nil, repeats: true)
            self.counter = 0.00
        }
    }
    @objc func UpdateTimer() {
        self.counter = self.counter + 0.05
     }

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
    
    @IBAction func load(_ sender: UIButton) {
        let n = Int.random(in: 0...100)
        DispatchQueue.global(qos: .utility).async {
        let url = URL(string: "https://i.picsum.photos/id/\(n)/0/0.jpg")!
        let data = try! Data(contentsOf: url)
            DispatchQueue.main.async {
            self.imageView.image = UIImage(data: data)
            }
        }
    }
}
