import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        let webRequest : NSURLRequest = NSURLRequest(url: NSURL(string: "https://mosmetro.ru/metro-map/")! as URL)
        webView.loadRequest(webRequest as URLRequest)
    }
}
