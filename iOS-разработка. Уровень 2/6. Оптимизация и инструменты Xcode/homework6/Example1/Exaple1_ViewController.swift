import UIKit

//MARK: -- refCount1
public var refCount1 = 0 {
    didSet {
        if refCount1 > 1 {
            print("*** Example_1 УТЕЧЕК: \(refCount1 - 1) ***")
        }
    }
}

protocol Example1Delegate { }

class Example1 {
    var delegate: Example1Delegate?
}

class Example1_ViewController: UIViewController, Example1Delegate {
    
    private let ref = Example1()
    
    override func viewDidLoad() {
        print(">> Example1 добавлен в память")
        refCount1 += 1
        ref.delegate = self
        if refCount1 > 1 {
            self.view.backgroundColor = .systemRed
        }
    }
    deinit {
        print("<<< Example1 удален из памяти!"); refCount1 -= 1
    }
}
