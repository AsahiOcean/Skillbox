import UIKit
//MARK:Обход утечки при использовании делегата
//MARK:важно указать что протокол применим только к классам (: class)
protocol Example2Delegate: class {
    // * * * * * * * * * * * //
}
class Example2weak {
    weak var delegate: Example2Delegate?
}

class Example2_ViewController: UIViewController, Example2Delegate {
    
    private let ref = Example2weak()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.delegate = self
        print(">> Example2 добавлен в память!")
    
    }
    deinit {
        print("<< Example2 удален из памяти!")
    }
}
