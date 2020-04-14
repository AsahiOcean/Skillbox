import UIKit

class MainViewController: UIViewController {
    
    var dvc: EmbedViewController?

    @IBAction func ButtonMainYellow(_ sender: Any) {
        dvc?.view.backgroundColor = .yellow
    }
    
    @IBAction func ButtonMainGreen(_ sender: Any) {
        dvc?.view.backgroundColor = .green
    }
    
    @IBAction func ButtonMainPurple(_ sender: Any) {
        dvc?.view.backgroundColor = .purple
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EmbedViewController, segue.identifier == "EmbedSegue" {
            vc.EmbedDelegator = self
            dvc = vc.self
        }
    }
}
extension MainViewController: EmbedDelegateProtocol {
    func ColorMainBackground(_ ColorOutEmbed: UIColor?) {
        self.view.backgroundColor = ColorOutEmbed
        
    }
}
