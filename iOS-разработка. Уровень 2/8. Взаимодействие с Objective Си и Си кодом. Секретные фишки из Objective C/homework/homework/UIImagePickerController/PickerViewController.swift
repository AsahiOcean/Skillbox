import UIKit
// Skillbox
// Скиллбокс

//2) напишите код, который с помощью swizzling’а добавляет в стандартный класс UIImagePickerController возможность сразу получить выбранную фотографию из галереи.

class PickerViewController: UIViewController {
    @IBOutlet weak var imageview: UIImageView!
    @IBAction func button(_ sender: UIButton) {
        self.picker.swizzling(vc: self, callback: { [weak self] output in
            guard let self = self else { return }
            // output - вывод originalImage в результате свизлинга
            DispatchQueue.main.async {
                self.imageview.image = output
            }
        })
    }

    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // задание 3 | objectassociation.swift
        print("identifier: \(self.view.identifier)")
    }
}

class PickedImage {
    // class PickedImage некий "прокси-сервер"
    // принимающий(через init) и отдающий значение
    var value: ((UIImage?) -> ())?
    init(_ value: @escaping (UIImage?) -> ()) {
        // @escaping удержит значение в памяти до того момента, когда это значение будет необходимо получить
        self.value = value
    }
}

extension UIImagePickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()
        // объявляем делегатом сам UIImagePickerController
        self.delegate = self
    }

    struct AssociatedKey {
        static var ImagePickedKey = "ImagePickedKey"
    }

    typealias ImagePicked = (UIImage?) -> (Void)
    var configurateImagePicked: ImagePicked? {
        get {
            print("getting ➡️")
            // получение значения у PickedImage для объекта по ключу
            let img = objc_getAssociatedObject(
                self, // объект
                &AssociatedKey.ImagePickedKey // ключ
                ) as? PickedImage
            return img?.value
        }
        set {
            print("setting ⬅️")
            objc_setAssociatedObject(
            self, // объект для которого создается связь
            
            &AssociatedKey.ImagePickedKey, // уникальный(!) ключ для ассоциации
            
            PickedImage(newValue!), // значение, которое будет связано с объектом
            
            objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            // objc_AssociationPolicy определяет поведение(тип) связи между объектом и значением
            // OBJC_ASSOCIATION_RETAIN - сохраняет сильную ссылку на значение атомарно(операция будет выполнена целиком, либо не выполнится вовсе), и значение существует до тех пор, пока существует объект, к которому он был привязан.
            // https://ru.wikipedia.org/wiki/Атомарная_операция
        }
    }

    func swizzling(vc: UIViewController, callback: ImagePicked?) {
        // callback = completion
        print("swizzling: ✅")

        print("swizzlingPicker: [\(UIImagePickerController.swizzlingPicker)] -- OK")
        
        //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        //MARK: toggle однократно(!) выполнит swizzlingPicker
        //MARK: тем самым картинка в UIImageView будет меняться
        UIImagePickerController.swizzlingPicker.toggle()
        //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        //MARK: не стоит подменять делегат установленный в viewDidLoad, иначе он не сможет обрабатывать выбранное изображение
        //self.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        
        // "привязываем" callback к configurateImagePicked
        // для получения данных внутри функции и дальнейшему выводу
        self.configurateImagePicked = callback
        
        // показ UIImagePickerController
        vc.present(self, animated: true, completion: nil)
    }
    
    fileprivate static var swizzlingPicker: Bool = {
        // #selector выполнит функцию и проверит существование метода
        let originalSelector = #selector(UIImagePickerController.imagePickerController(_:didFinishPickingMediaWithInfo:))
        let swizzledSelector = #selector(UIImagePickerController.extImagePickerController(_:didFinishPickingMediaWithInfo:))
        
        // класс в котором будут заменены методы
        let instanceClass = UIImagePickerController.self
        
        // описание и вызов методов
        let originalMethod = class_getInstanceMethod(instanceClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(instanceClass, swizzledSelector)
        
        let didAddMethod =
            class_addMethod(instanceClass, originalSelector,
            method_getImplementation(swizzledMethod!),
            method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod {
            print("didAddMethod: replaceMethod")
            class_replaceMethod(instanceClass, swizzledSelector,
            method_getImplementation(originalMethod!),
            method_getTypeEncoding(originalMethod!))
        } else {
            print("didAddMethod: exchange ")
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
        return true
    }()

    @objc public func extImagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // прием данных из UIImagePickerController
        let originalImage = info[.originalImage] as? UIImage
        
        // присвоение картинки в configurateImagePicked
        self.configurateImagePicked?(originalImage)

        print("Finish Picking 👍")

        self.dismiss(animated: true, completion: {
            print("swizzlingPicker: [\(UIImagePickerController.swizzlingPicker)] -- OK")
            print("extImagePickerController: dismiss")
        })
    }

    @objc public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        print("Fail swizzling 🤦‍♂️")

        self.dismiss(animated: true, completion: {
            print("imagePickerController: dismiss")
        })
    }
}
