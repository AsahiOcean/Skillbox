import UIKit

class DeletePopoverViewController: UIViewController {
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBAction func deleteAction(_ sender: UIButton) {
        if let delegate = delegate, let indexPath = indexPath {
            delegate.deleteItem(indexPath: indexPath); exit()
        }}
    
    @IBAction func backAction(_ sender: UIButton) { exit() }
    
    var indexPath: IndexPath?
    var delegate: DeletePopoverViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        popoverView.layer.cornerRadius = 10
        
        yesButton.layer.cornerRadius = 10
        noButton.layer.cornerRadius = 10
        noButton.layer.borderWidth = 1
        noButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    private func exit() {
        self.view.removeFromSuperview()
    }
}

protocol DeletePopoverViewControllerDelegate: AnyObject {
    func deleteItem(indexPath: IndexPath)
}
