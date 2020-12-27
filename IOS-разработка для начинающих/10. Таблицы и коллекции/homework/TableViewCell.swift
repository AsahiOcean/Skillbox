import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var IconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var Switch: UISwitch!
    
    @IBAction func SwitchTap(_ sender: Any) {
        if nameLabel.text == "Авиарежим" {
            Switch.isOn == true ? print("Включен Авиарежим") : print("Авиарежим отключен")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Switch.isOn = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            print("\(nameLabel.text!)")
        }
    }
}
