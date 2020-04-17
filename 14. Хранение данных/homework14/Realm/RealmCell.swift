import UIKit

class RealmCell: UITableViewCell {
    
    let forminfo = AddFormConfig()
    
    @IBOutlet weak var NameSurname: UILabel!
    @IBOutlet weak var DateTime: UILabel!
    @IBOutlet weak var TaskText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let name = self.forminfo.name
        let surname = self.forminfo.surname
        
        if ((name?.isEmpty) == nil) && ((surname?.isEmpty) == nil) {
            NameSurname.text = "anonymous"
        } else if ((name?.isEmpty) != nil) && ((surname?.isEmpty) == nil) {
            NameSurname.text = "\(name!)"
        } else if ((name?.isEmpty) == nil) && ((surname?.isEmpty) != nil) {
            NameSurname.text = "\(surname!)"
        } else {
            NameSurname.text = "\(name!) \(surname!)"
        }
    }
}
