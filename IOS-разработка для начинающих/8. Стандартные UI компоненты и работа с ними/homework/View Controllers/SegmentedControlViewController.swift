import UIKit

class SegmentedControlViewController: UIViewController {

    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var View3: UIView!
    
    
    @IBAction func Segmetes(_ sender: Any) {
        switch SegmentedControl.selectedSegmentIndex {
        case 0:
            View1.layer.isHidden = false
            View2.layer.isHidden = true
            View3.layer.isHidden = true
        case 1:
            View1.layer.isHidden = true
            View2.layer.isHidden = false
            View3.layer.isHidden = true
        case 2:
            View1.layer.isHidden = true
            View2.layer.isHidden = true
            View3.layer.isHidden = false
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        View1.layer.isHidden = false
        View2.layer.isHidden = true
        View3.layer.isHidden = true
    }
}
