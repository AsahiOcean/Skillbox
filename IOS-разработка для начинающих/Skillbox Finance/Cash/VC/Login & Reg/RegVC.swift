import UIKit
import RealmSwift

class RegVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var RegButton: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var photo: UIImageView!
    
    fileprivate var login = ""
    fileprivate var mail = ""
    fileprivate var pass = ""
    var imagePicker = UIImagePickerController()
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    
    @IBAction func LoginEdit(_ sender: Any) {login = username.text!}
    @IBAction func emailEdit(_ sender: Any) {mail = email.text!}
    @IBAction func passEdit(_ sender: Any) {pass = passTF.text!}
    
    @IBAction func Reg(_ sender: Any) {
        Persistance().add(info: "userinfo")
        let userinfo = self.realm.objects(UserInfo.self)
        if let userinfo = userinfo.last {
            try! self.realm.write {
                userinfo.login = "\(self.username.text!)"
                userinfo.email = "\(self.email.text!)"
                userinfo.pass = "\(self.passTF.text!)"
                userinfo.ImageData = photo.image!.pngData()!
            }
        }
    }
    
    @IBAction func didPressButton(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected { RegButton.alpha = 1.0 }
    }
    
    @IBAction func ChangePhoto(_ sender: Any) {
        // TODO: Сделать чтоб фотки загружались
        // Сделано
        
        let alert = UIAlertController(title: "Откуда?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Сделать фото", style:
                                        .default, handler: { _ in self.MakePhoto() }))
        alert.addAction(UIAlertAction(title: "Из галереи", style:
                                        .default, handler: { _ in self.OpenGallery() }))
        alert.addAction(UIAlertAction.init(title: "Отмена", style:
                                            .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func MakePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "", message: "Переверните компуктер", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func OpenGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "", message: "Нет доступа к галерее", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let compressImage = selectedImage.jpeg(.lowest) {
                photo.image = UIImage(data: compressImage)
            }
            photo.contentMode = .scaleToFill
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        photo.image = defaultPhoto
        
        // Периферия
        self.view.addSubview(BackgroundVideo())
    }
}
