import UIKit
import CoreData

class CoreDataCell: UITableViewCell {
    
    @IBOutlet weak var NameSurname: UILabel!
    @IBOutlet weak var DateTime: UILabel!
    @IBOutlet weak var TaskText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
