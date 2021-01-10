import UIKit
import Bond
import ReactiveKit

class ViewController: UIViewController {
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        // При изменении в текстовом поле имени, значение будет отправляться в свойство name
        nameTextField.reactive.text.ignoreNils()
            .bind(to: viewModel.name)
        
        actionButton.reactive.tap.bind(to: viewModel.updateGreeting)
        
        viewModel.greeting.bind(to: greetingLabel.reactive.text)
    }
}
