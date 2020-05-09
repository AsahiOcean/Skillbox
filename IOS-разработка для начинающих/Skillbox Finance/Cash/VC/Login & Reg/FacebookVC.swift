import UIKit

class FacebookVC: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var preview: UIImageView!
    let Url : NSURL = NSURL(string: "https://m.facebook.com/login/")!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preview.isHidden = true
        let webRequest : NSURLRequest = NSURLRequest(url: Url as URL)
        webView.loadRequest(webRequest as URLRequest)
    }
}
