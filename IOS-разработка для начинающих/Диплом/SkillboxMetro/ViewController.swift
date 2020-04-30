import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    let Url : NSURL = NSURL(string: "https://mosmetro.ru/metro-map/")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webRequest : NSURLRequest = NSURLRequest(url: Url as URL)
        webView.delegate = self
        webView.loadRequest(webRequest as URLRequest)
    }
}
