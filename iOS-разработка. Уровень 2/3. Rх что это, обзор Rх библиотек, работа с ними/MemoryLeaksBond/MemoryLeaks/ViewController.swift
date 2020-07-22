import UIKit
import Bond
// Skillbox
// Скиллбокс

class ViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!
    var processor: (() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        addButton.reactive.tap.observeNext { [ weak self] in
//            self?.dateprint()
//        }
        
        // unowned - если мы уверены, что self не будет nil
        addButton.reactive.tap.observeNext {
            self.dateprint()
        }.dispose(in: reactive.bag)
        
//        processor = {
//            self.dateprint()
//        }
        
        let h1 = Human()
        let h2 = Human()
        
        h1.friend = h2
        h2.friend = h1
    }
    
    func dateprint() {
        print(Date())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // тогда можно не писать [ unowned self] in
        // удаляет reactive.bag
        reactive.bag.dispose()
    }
}

class Human {
    weak var friend: Human?
    
    init() {
        print("Human +++++")
    }
    
    deinit {
        print("Human -----")
    }
}
