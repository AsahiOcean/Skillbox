import UIKit
import RealmSwift

class BasketVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    
    @IBAction func buy(_ sender: Any) {
        let userinfo = self.realm.objects(UserInfo.self)
        if let userinfo = userinfo.first {
        try! self.realm.write {
        let price = priceLabel.text?.dropLast()
        let sum = Int(price!)!
        userinfo.orders += 1
        userinfo.portacheno = sum
        }}
        
        let MoneyNotif = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoneyNotif") as! MoneyNotif
        self.addChild(MoneyNotif)
            
        MoneyNotif.view.frame = CGRect(x: 0, y: self.view.frame.minY, width: view.frame.width, height: 200)
        
        self.view.addSubview(MoneyNotif.view)
        MoneyNotif.didMove(toParent: self)
        }
    
        private var items = Persistance.shared.getProducts()
        private var images: [UIImage] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            orderButton.layer.cornerRadius = 10
            addImage(); sum()
        }
            
        private func sum(){
        var sum = 0
        for item in items {
            sum += Int(item.price) ?? 0 }
            priceLabel.text = String(sum)  + "₽"
        if sum == 0 { orderButton.isEnabled = false
            orderButton.alpha = 0.5
        } else {
            orderButton.isEnabled = true
        }}
        
        private func addImage(){
        for index in self.items.indices {
        Loader().loadImage(link:self.items[index].mainImageLink) { gotImage in
        if let image = gotImage {
        self.images.append(image)
        self.tableView.reloadData()
        }}}}
    }

extension BasketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            items.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketTableViewCell
        cell.nameLabel.text = items[indexPath.row].name
        cell.sizeLabel.text = items[indexPath.row].size
        cell.colorLabel.text = items[indexPath.row].colorName
        cell.priceLabel.text = items[indexPath.row].price + " ₽"
        if indexPath.row < images.count {
        cell.productImage.image = images[indexPath.row]
        }
        cell.indexPath = indexPath
        return cell
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
    Persistance.shared.removeProduct(index: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .automatic)
    tableView.reloadData(); sum()
    }}
    }

    extension BasketVC: DeletePopoverVCDelegate {
        func deleteItem(indexPath: IndexPath) {
        Persistance.shared.removeProduct(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData(); sum()
        }
    }
