import UIKit
import GoogleSignIn
// https://github.com/googlesamples/google-services/tree/bf40e8939ba75476c6b72aec68d13488acf97f1e/ios/signin

class GoogleVC: UIViewController {
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var statusText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Автоматический вход пользователя
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        NotificationCenter.default.addObserver(self, selector: #selector(GoogleVC.receiveToggleAuthUINotification(_:)), name: NSNotification.Name(rawValue:"ToggleAuthUINotification"), object: nil)
        statusText.text = "Initialized Swift app..."
        toggleAuthUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Для вывода username после автоматического входа, иначе в statusText было "Initialized Swift app..."
        guard let username =         GIDSignIn.sharedInstance()?.currentUser?.profile.name  else { return }
        statusText.text = "Вы вошли как\n\(username)"
    }

    @IBAction func didTapSignOut(_ sender: AnyObject) {
        // Помечает, что пользователь вышел из системы
        GIDSignIn.sharedInstance().signOut()
        statusText.text = "Signed out."
        toggleAuthUI()
    }

    @IBAction func didTapDisconnect(_ sender: AnyObject) {
        // Отключает пользователя от приложения и отменяет предыдущую аутентификацию
        GIDSignIn.sharedInstance().disconnect()
        statusText.text = "Disconnecting."
    }
    
    func toggleAuthUI() {
    if let _ = GIDSignIn.sharedInstance()?.currentUser?.authentication {
      signInButton.isHidden = true
      signOutButton.isHidden = false
      disconnectButton.isHidden = false
    } else {
      signInButton.isHidden = false
      signOutButton.isHidden = true
      disconnectButton.isHidden = true
      statusText.text = "Google Sign in\niOS Demo"
    }
  }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    deinit {
        NotificationCenter.default.removeObserver(self,
            name: NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil)
    }

    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
        if notification.name.rawValue == "ToggleAuthUINotification" {
            if notification.userInfo != nil {
                guard let userInfo = notification.userInfo as? [String:String] else { return }
                // Получение имени и фамилии (get username)
                self.statusText.text = userInfo["statusText"]!
                
                // MARK: Без этого не появлялись кнопки для выхода
                // Сомневаюсь, что ребята из гугла промахнулись, но может быть и такое, а возможно и я где-то ошибся, что без дополнительной строчки не переключалась видимость кнопок
                self.toggleAuthUI()
            }
        }
    }
}
