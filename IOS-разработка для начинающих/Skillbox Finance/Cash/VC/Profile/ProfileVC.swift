import UIKit
import RealmSwift

class ProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Surname: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var ViewProfileButton: UIButton!
    
    @IBAction func ToProfileHistory(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileHistoryVC")
        self.definesPresentationContext = true
        vc?.modalPresentationStyle = .popover
        self.present(vc!, animated: true, completion: nil)
    }
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userinfo = self.realm.objects(UserInfo.self)
        Name.text = "\(userinfo.first!.name)"
        Surname.text = "\(userinfo.first!.surname)"
        
        // банально простая проверка
        if userinfo.first!.ImageData.isEmpty {
            photo.image = defaultPhoto
        } else {
            photo.image = UIImage(data: userinfo.first!.ImageData)
        }
    }
    
    @IBAction func ChangePhoto(_ sender: Any) {
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
}
