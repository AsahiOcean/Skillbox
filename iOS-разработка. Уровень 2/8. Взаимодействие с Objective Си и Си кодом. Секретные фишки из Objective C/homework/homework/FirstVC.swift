import UIKit
// Skillbox
// Скиллбокс

class FirstVC: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBAction func color1btn(_ sender: UIButton) {
        performSegueWithIdentifier(identifier: "SecondVC", sender: sender) { segue in
            let vc = segue.destination as? SecondVC
            vc?.hexStr = "#DC143C"
        }
    }
    
    @IBAction func color2btn(_ sender: UIButton) {
        performSegueWithIdentifier(identifier: "SecondVC", sender: sender) { segue in
            let vc = segue.destination as? SecondVC
            vc?.hexStr = "#1E90FF"
        }
    }
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard self.text == "" else {
            print("Приняты данные: \(self.text)")
            return self.label.text = self.text
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
          self.btn1.layer.cornerRadius = self.btn1.bounds.size.width/2
          self.btn1.clipsToBounds = true
            
          self.btn2.layer.cornerRadius = self.btn2.bounds.size.width/2
          self.btn2.clipsToBounds = true
        }
    }
    
    deinit { print("\(self.classForCoder) deinit -- \(Date())") }
}
