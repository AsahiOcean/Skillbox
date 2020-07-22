import UIKit
// Skillbox
// Скиллбокс

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var loadtimer: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var (timer,timerLoad): (Timer?,Timer?)
    var stopwatch: Float = 0.00 {
    didSet { self.time.text = String(format: "%.2f", stopwatch) }}
    var timeLoad : Float = 0.00 {
    didSet { self.loadtimer.text = String(format: "%.2f", timeLoad) }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector: #selector(self.UpdateTimer), userInfo: nil, repeats: true)
            self.stopwatch = 0.00
        }
    }
    @objc func UpdateTimer() { self.stopwatch = self.stopwatch + 0.05 }
    @objc func TimerImage() { self.timeLoad = self.timeLoad + 0.05 }
    
    var loadingImage: DispatchWorkItem?

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
    
    @IBAction func load(_ sender: UIButton) {
        self.timeLoad = 0.00
        self.timerLoad = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector: #selector(self.TimerImage), userInfo: nil, repeats: true)
        self.imageView.isHidden = true
        let n = Int.random(in: 0...100)
        
        // MAIN
        loadingImage = DispatchWorkItem { [weak self] in
            let url = URL(string: "https://i.picsum.photos/id/\(n)/0/0.jpg")!
            let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                self!.imageView.isHidden = false
                if data != nil {
                    self!.imageView.image = UIImage(data: data!)
                    self!.timerLoad?.invalidate()
                }
                }
            }
    DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 2, execute: loadingImage!)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.loadingImage?.cancel()
        self.imageView.isHidden = false
        self.imageView.image = nil
        self.timerLoad?.invalidate()
    }
}
