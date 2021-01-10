import UIKit
import Bond
import ReactiveKit

/*
 1. Presenter - хранит внутренее состояние и обрабывает события,
 передает либо в Interactor, либо в Router
 и возвращает результат в Controller
 
 2. Interactor - внешнее взаимодействие, любая логика и работа с внешними библиотеками
 
 3. Router - отвечает за переходы
 */

class ViewController: UIViewController {
    @IBOutlet weak var greetinLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func textChanged(_ sender: UITextField) {
        //        presenter.nameUpdated(name: nameTextField.text ?? "")
        
        // реагирование на изменение
        presenter.nameUpdated(name: sender.text!)
    }
    
    var presenter: PresenterInput! = Presenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.output = self
    }
}
// Presenter - некий аналог ViewModel
extension ViewController: PresenterOutput {
    func updateGreeting(greeting: String) {
        greetinLabel.text = greeting
    }
}
