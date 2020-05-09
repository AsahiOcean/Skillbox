import UIKit
import RealmSwift

class ProfileHistoryVC: UIViewController {
    
    @IBOutlet weak var noorders: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    private var historyItems = Persistance.shared.getItemsHistory()
    private var images: [UIImage] = []
    
    @IBAction func toshop(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListsNC") // NavigationController
        self.definesPresentationContext = true
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckOrders();
    }
    
    func CheckOrders() {
        let userinfo = self.realm.objects(UserInfo.self)
        if userinfo.first!.orders != 0 {
            tableView.isHidden = false
            noorders.isHidden = true
            addImage()
        } else {
            tableView.isHidden = true
            noorders.isHidden = false
        }
    }
    
    private func addImage(){
        for index in self.historyItems.indices {
    Loader().loadImage(link: self.historyItems[index].mainImageLink) {
                gotImage in
                if let image = gotImage {
                    self.images.append(image)
                    self.tableView.reloadData()
                }
            }
        }
    }
}
extension ProfileHistoryVC: UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historyItems.count
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
    cell.nameLabel.text = historyItems[indexPath.row].name
    cell.sizeLabel.text = historyItems[indexPath.row].size
    cell.colorLabel.text = historyItems[indexPath.row].colorName
    cell.priceLabel.text = historyItems[indexPath.row].price + " ₽"
    if indexPath.row < images.count {
        cell.productImage.image = images[indexPath.row]
    }
//    cell.indexPath = indexPath
//    cell.delegate = self
    return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Почти получилось :)")
        }
    }
}
