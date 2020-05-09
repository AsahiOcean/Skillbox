import UIKit

class AboutAppVC: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var webGif: UIWebView!
    
    let Url : NSURL = NSURL(string: "https://s6.gifyu.com/images/elmo.gif")!
    
    var version = 1.0
    var build = 1000
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.versionLabel.text = "\(version)"
        self.buildLabel.text = "\(build)"
        let webRequest : NSURLRequest = NSURLRequest(url: Url as URL)
        webGif.delegate = self
        webGif.loadRequest(webRequest as URLRequest)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
    }
    
    @objc func timerFunc() { Plus() }
    private func Plus() {
        let ver = Float(self.versionLabel.text!)
        self.versionLabel.text = String(String(ver! + 1.1).prefix(4))
        let build = Int(self.buildLabel.text!)
        self.buildLabel.text = String(String(build! + 123))
        
        let formatdate = DateFormatter()
        formatdate.dateStyle = .medium
        let date = formatdate.string(from: Date())
        let formattime = DateFormatter()
        formattime.timeStyle = .medium
        let time = formattime.string(from: Date())
        self.dateLabel.text = "\(date) \(time)"
    }
}
