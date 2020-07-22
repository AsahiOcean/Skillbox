import UIKit
// Skillbox
// Скиллбокс
//1) добавьте в проект SegueSwizzler: https://drive.google.com/open?id=1xqRpsiNbUTsVFsJYsQUfXMvPwFqfZeTx сделайте несколько переходов на другие экраны с передачей данных на них с помощью нового performSegue

class SwizzlerViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!
    @IBAction func button(_ sender: UIButton) {
        guard textfield.text?.isEmpty == false else { return }
        
        performSegueWithIdentifier(identifier: "FirstVC", sender: sender) { segue in
            let vc = segue.destination as? FirstVC
            vc?.text = self.textfield.text!
            self.textfield.text = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit { print("\(self.classForCoder) deinit -- \(Date())") }
}
