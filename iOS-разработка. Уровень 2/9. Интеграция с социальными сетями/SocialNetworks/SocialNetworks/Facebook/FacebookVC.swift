import UIKit
import FacebookCore
import FBSDKLoginKit
import FacebookShare


// Сделайте проект, в который добавите социальные сети с возможностью авторизации и шейринга через них: facebook
// https://developers.facebook.com/docs/ios

class FacebookVC: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    //  кнопка для подмены на фирменную кнопку facebook
    @IBOutlet weak var ShareButton: UIButton!
    
    // публикация изображения
    @IBOutlet weak var photocard: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sendImageButton: UIButton!
    @IBAction func sendImage(_ sender: UIButton) {
        photo.image = imageView.image
        photoContent.photos = [photo]
        shareDialog.shareContent = photoContent
        
        //MARK: пока не нашел способа как реализовать шаринг фото через ".web" (WKWebView), вылазит ошибка:
        /*
         Error Domain=com.facebook.sdk.share Code=2 "(null)" UserInfo={com.facebook.sdk:FBSDKErrorArgumentValueKey=<FBSDKSharePhoto: 0x000000000000>, com.facebook.sdk:FBSDKErrorDeveloperMessageKey=imageURL is required., com.facebook.sdk:FBSDKErrorArgumentNameKey=photo}
         */
        // через ".browser" приходится авторизовываться второй раз, что ужасно лень делать, при том, что "Вход через Facebook" происходит через браузер, куки должны сохраниться там, но что-то идет не так
        shareDialog.mode = .browser
        self.shareDialog.show()
    }
    @IBAction func reserveShare(_ sender: UIButton) {
        // с ссылками и комментариями ".web" (WKWebView) работает нормально
        shareDialog.shareContent = linkContent
        linkContent.quote = "Рекомендую"
        self.shareDialog.show()
    }
    
    
    let url = URL(string: "https://github.com/AsahiOcean")!
    
    let fbLoginButton = FBLoginButton()
    //let fbButton = FBButton() // простая кнопка
    
    // Share
    let shareDialog = ShareDialog()
    let linkContent = ShareLinkContent()
    let fbShareButton = FBShareButton()
    let photoContent = SharePhotoContent()
    let photo = SharePhoto()
    
    let picker = UIImagePickerController()
    @objc func openPicker()
    {
        present(picker, animated: true, completion: nil)
    }
    
    let fbLoginManager: LoginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.uiDelegate = self
        self.webView.load(URLRequest(url: url))
        self.webView.scrollView.contentInset.top = -350
        
        // замена фото с собакой
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(openPicker))
        imageView.addGestureRecognizer(tap)
        
        self.sendImageButton.layer.cornerRadius = 5
        self.photocard.layer.cornerRadius = 10
        
        //MARK: UIImagePickerController
        picker.delegate = self
        //picker.allowsEditing = false
        //picker.sourceType = .photoLibrary
        
        //MARK: -- ShareLinkContent
        linkContent.contentURL = url
        
        // MARK: -- ShareDialog
        shareDialog.delegate = self
        shareDialog.fromViewController = self
        shareDialog.mode = .web
        
        photo.isUserGenerated = true
        
        //MARK: -- FBLoginButton
        self.fbLoginButton.delegate = self
        self.LoginButton?.setTitle(nil, for: .normal)
        DispatchQueue.main.async {
            self.fbLoginButton.center = self.LoginButton.center
        }
        self.view.addSubview(fbLoginButton)
        
        //MARK: -- FBShareButton
        //https://developers.facebook.com/docs/sharing/ios/share-button
        self.ShareButton.setTitle(nil, for: .normal)
        DispatchQueue.main.async {
            self.fbShareButton.center = self.ShareButton.center
            self.fbShareButton.shareContent = self.linkContent
        }
        self.view.addSubview(fbShareButton)
        
        if let token = AccessToken.current,
           !token.isExpired {
            // Действие после проверки авторизации Facebook
            self.getUserInfo()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: GraphRequest(graphPath: "me"):
    //        fetched user:{
    //            id = 000000000000;
    //            name = "FirstName LastName";
    //        }
    private func getUserInfo() {
        if (AccessToken.current != nil) {
            GraphRequest(graphPath: "me", parameters: [
                "fields": "id,first_name,last_name,name,picture{url},relationship_status"
                //MARK: Руководство: https://developers.facebook.com/docs/graph-api/explorer/
                //MARK: Настройка запросов на доступ к данным: https://developers.facebook.com/tools/explorer
            ]).start(completionHandler: { connection, result, error in
                //print("connection: \(connection!)")
                if error == nil {
                    if let result = result {
                        let get = result as! NSDictionary
                        self.firstName.text = get["first_name"] as? String
                        self.lastName.text = get["last_name"] as? String
                        //MARK: URL фото профиля
                        if let imageURL = ((get["picture"] as? [String: Any])? ["data"] as? [String: Any])? ["url"] as? String {
                            self.userPhoto.load(url: imageURL)
                        }
                    }
                } else {
                    print("error: \(error!)")
                }
            })
        }
    }
}
extension FacebookVC: LoginButtonDelegate, SharingDelegate, WKUIDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("loginButtonDidLogOut")
    }
    
    //MARK: -- LoginButtonDelegate
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        //print("loginButton")
        if result?.token?.userID != nil {
            self.getUserInfo()
        }
    }
    
    //MARK: -- SharingDelegate
    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        if sharer.shareContent.pageID != nil {
            print("success")
        }
    }
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        print(error)
        print("fail")
    }
    func sharerDidCancel(_ sharer: Sharing) {
        print("cancel")
    }
    
    //MARK: -- UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
        }; dismiss(animated: true, completion: nil)
    }
}
extension UIImageView {
    func load(url: String) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: url)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
