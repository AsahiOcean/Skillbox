import UIKit
import RealmSwift

class PopoverSizeViewController: UIViewController {

    @IBOutlet var sizeView: UIView!
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    
        var product: Product? = nil
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.showAnimate()
        }
    }

    extension PopoverSizeViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            self.product?.offers?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sizeCell", for: indexPath) as! SizeCellTableViewCell
            guard let product = self.product, let offers = product.offers else { return cell }
            cell.sizeLabel.text = product.name + " " + (offers[indexPath.row]["size"] ?? "")
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let product = self.product,
        let offers = product.offers {
        let buyItem = ProductObject()
        let hiscoryItem = HistoryProduct()
        buyItem.getData(id: product.id, name: product.name, colorName: product.colorName, mainImageLink: product.mainImageLink, price: product.price, size: offers[indexPath.row]["size"] ?? "")
        hiscoryItem.getData(id: product.id, name: product.name, colorName: product.colorName, mainImageLink: product.mainImageLink, price: product.price, size: offers[indexPath.row]["size"] ?? "")
        
            Persistance.shared.saveProduct(item: buyItem)

            Persistance.shared.saveHistoryProduct(item: hiscoryItem)
        }
            removeAnimate()
        }
        
        private func showAnimate(){
            self.view.transform = .init(translationX: 0, y: self.view.bounds.height)
            UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = .init(translationX: 0, y: 0)
            })
        }
        
        private func removeAnimate() {
            UIView.animate(withDuration: 0.25, animations: {
                self.view.transform = .init(translationX: 0, y: self.view.bounds.height)
            }, completion: {
            finished in if finished {
                self.removeFromParent()
            }})
        }
    }
