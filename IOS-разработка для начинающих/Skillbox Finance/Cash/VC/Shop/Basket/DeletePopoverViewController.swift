import UIKit

protocol DeletePopoverVCDelegate: AnyObject {
    func deleteItem(indexPath: IndexPath)
}
class DeletePopoverVC: UIViewController {
    @IBOutlet weak var popoverView: UIView!
    @IBAction func TouchYes(_ sender: Any) {
        if let delegate = delegate, let indexPath = indexPath {
            delegate.deleteItem(indexPath: indexPath)
        }}
    @IBAction func TouchNo(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    var indexPath: IndexPath?
    var delegate: DeletePopoverVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popoverView.layer.cornerRadius = 20
        let gestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(yourActionMethod))
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    // удаление окна при нажатии вне видимой вью
    @objc func yourActionMethod() {
        self.view.removeFromSuperview()
    }
}
extension DeletePopoverVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}
