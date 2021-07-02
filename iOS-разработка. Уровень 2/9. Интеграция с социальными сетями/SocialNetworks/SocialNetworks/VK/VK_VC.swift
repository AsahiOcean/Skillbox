import UIKit
import VK_ios_sdk

// https://vk.com/dev/ios_sdk
// https://vk.com/dev/first_guide

class VK_VC: UIViewController {
    
    @IBOutlet weak var ImagePost: UIImageView!
    let picker = UIImagePickerController()
    
    @IBOutlet weak var AddPostButton: UIButton!
    @IBAction func AddPostAction(_ sender: UIButton) {
        
        let shareDialog = VKShareDialogController()
        
        shareDialog.requestedScope = SCOPE
        
        // Добавьте текстовую информацию в диалог. Обратите внимание, что пользователи смогут её изменять
        shareDialog.text = "This post created using #vksdk #ios"
        
        // Прикрепите изображения, ранее загруженные в VK
        // https://vk.com/photo-60479154_333497085
        shareDialog.vkImages = ["-60479154_333497085"]
        
        // Если вы хотите, чтобы пользователь загрузил новое изображение, используйте свойство uploadImages
        let image = VKUploadImage(image: ImagePost.image, andParams: VKImageParameters.jpegImage(withQuality: 1.0))
        shareDialog.uploadImages = [image!]
        
        // Прикрепите ссылку на нужную страницу
        shareDialog.shareLink = VKShareLink(title: "Super puper link, but nobody knows", link: URL(string: "https://github.com/AsahiOcean"))
        
        self.present(shareDialog, animated: true)
        
        // блок, отслеживающий завершение диалога
        shareDialog.completionHandler = { VKShareDialogController, result in
            if VKSdk.accessToken()?.accessToken != nil {
                // https://vk.com/dev/wall.get
                print("\n~ ~ ~ JSON всех постов на стене: ~ ~ ~")
                print("https://api.vk.com/method/wall.get?&access_token=\(VKSdk.accessToken().accessToken!)&v=5.84")
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    let sdkInstance = VKSdk.initialize(withAppId: "7511232")
    
    // Полный список доступных разрешений здесь:
    /// https://vk.com/dev/permissions
    let SCOPE = ["friends","email","wall","photos"]
    
    // "wall","photos" для публикации постов согласно описанию в requestedScopeself.
    
    @IBOutlet weak var VKLoginButton: UIButton!
    @IBAction func VKLogin(_ sender: UIButton) {
        VKSdk.wakeUpSession(SCOPE, complete: { state, error in
            if state == .authorized {
                print("\nForces logout")
                VKSdk.forceLogout()
                
                // - - - - - - - - - - - - - - - - - - - - - - - -
                self.VKLoginButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
                self.VKLoginButton.setTitle("Войти в VK", for: .normal)
                self.AddPostButton.isEnabled = false
            } else {
                print("Нажата кнопка авторизации")
                VKSdk.authorize(self.SCOPE, with: .disableSafariController)
                // одновременно с этим метод vkSdkAccessAuthorizationFinished ждет результат и выполняет прописанные в нем задачи
            }
        })
    }
    
    @objc func openPicker() {
        present(picker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sdkInstance?.register(self)
        sdkInstance?.uiDelegate = self
        
        VKSdk.wakeUpSession(SCOPE, complete: { state, error in
            if state == .authorized {
                //autorized
                print("Пользователь авторизован")
                print("https://vk.com/id\(VKSdk.accessToken().userId!)")
                print()
                self.JSONnewsfeed()
            } else {
                //autorized neaded
                print("Пользователь не авторизован")
                if error != nil {
                    print("Error: \(error!.localizedDescription)")
                }
            }
        })
        
        self.picker.delegate = self
        self.ImagePost.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(openPicker))
        self.ImagePost.addGestureRecognizer(tap)
    }
    
    /// получение данных от ВК по запросу
    func JSONnewsfeed() {
        // https://vk.com/dev/newsfeed.get
        print("~ ~ ~ JSON новостной ленты: ~ ~ ~")
        print("https://api.vk.com/method/newsfeed.get?filters=post, photo&access_token=\(VKSdk.accessToken().accessToken!)&v=5.110")
        // 5.110 - последняя версия API на 19.06.2020
        // - - - - - - - - - - - - - - - - - - - - - - - -
        self.AddPostButton.isEnabled = true
        self.VKLoginButton.setTitleColor(#colorLiteral(red: 0.8366223574, green: 0.2327688634, blue: 0.1971235871, alpha: 1), for: .normal)
        self.VKLoginButton.setTitle("Выйти", for: .normal)
    }
}

extension VK_VC: VKSdkDelegate, VKSdkUIDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            print("Пользователь успешно авторизован")
            self.JSONnewsfeed()
        } else if result.error != nil {
            print("Пользователь отменил авторизацию или произошла ошибка")
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("vkSdkUserAuthorizationFailed")
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        guard controller != nil else {
            return print("Ошибка vkSdkShouldPresent")
        }
        self.present(controller, animated: true, completion: {
            print("Переход в окно авторизации")
        })
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("vkSdkNeedCaptchaEnter")
        let vc = VKCaptchaViewController.captchaControllerWithError(captchaError)
        vc?.present(in: self)
    }
    
    //MARK: -- UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            ImagePost.image = image
        }; dismiss(animated: true, completion: nil)
    }
}
