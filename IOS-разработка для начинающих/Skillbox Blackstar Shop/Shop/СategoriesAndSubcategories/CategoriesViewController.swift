import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader().loadCategories(completition: {
            categories in
            self.categories = categories
            self.tableView.reloadData()
            self.addImage()
        })
    }
    
    private func addImage(){
        for index in self.categories.indices {
            Loader().loadImage(link: self.categories[index].imageLink){
                gotImage in
                self.categories[index].image = gotImage
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "SubcategoriesSegue",
            let destination = segue.destination as? SubcategoriesViewController,
            let cell = sender as? UITableViewCell,
            let i = tableView.indexPath(for: cell),
            let subcategories = categories[i.row].subcategories
        {
            destination.subcategories = subcategories
            destination.screenName = categories[i.row].name
        } else if
            segue.identifier == "CatalogSegueFromMain",
            let destination = segue.destination as? CatalogCollectionViewController,
            let cell = sender as? UITableViewCell,
            let i = tableView.indexPath(for: cell)
        {
            destination.categoryId = categories[i.row].id
            destination.screenName = categories[i.row].name
        }
    }
}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell") as! CategoriesTableViewCell
        cell.categoryName.text = categories[indexPath.row].name
        
        if let image = categories[indexPath.row].image {
            let width = cell.categoryImage.frame.width
            let newSize = CGSize(width: width, height: image.size.height * width / image.size.width)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            // смещение
            image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            cell.categoryImage.image = newImage

            cell.categoryImage.contentMode = UIView.ContentMode.top
        } else {
            if cell.categoryName.text == "Обувь" { // картинка nil
                cell.categoryImage.image = UIImage(named: "bashmaki")
            } else if cell.categoryName.text == "Коллекции" {
                cell.categoryImage.image = UIImage(named: "collection")
            } else if cell.categoryName.text == "Предзаказ" {
                cell.categoryImage.image = UIImage(named: "predzakaz")
            } else {
                cell.categoryImage.image = nil
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !categories[indexPath.row].subcategories!.isEmpty{
            performSegue(withIdentifier: "SubcategoriesSegue", sender: tableView.cellForRow(at: indexPath))
        } else {
            performSegue(withIdentifier: "CatalogSegueFromMain", sender: tableView.cellForRow(at: indexPath))
        }
    }
}
