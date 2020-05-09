import UIKit

class SubcategoriesViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var TitleCategory: String = ""

    var subcategories: [Category] = [] // изначальный массив
    var displayData: [Category] = [] // массив для результатов поиска

    override func viewDidLoad() {
        super.viewDidLoad()
        addImage()
        displayData = subcategories // дублируем
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = self.TitleCategory
    }
             
    private func addImage(){
        for index in self.subcategories.indices {
        Loader().loadImage(link:
        self.subcategories[index].imageLink) {
            gotImage in
        self.subcategories[index].image = gotImage
        self.displayData[index].image = gotImage
        self.tableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "CatalogSegueFromSubcategories",
    let destination = segue.destination as? CatalogCollectionVC,
    let cell = sender as? UITableViewCell,
    let index = tableView.indexPath(for: cell) {
        destination.categoryId = displayData[index.row].id
        destination.TitleCategory = displayData[index.row].name
    }}
}

    extension SubcategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData.count
    }
             
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell") as! CategoriesTableViewCell
    cell.categoryName.text = displayData[indexPath.row].name

    if let image = displayData[indexPath.row].image {
        cell.categoryImage.image = image
    } else {
        cell.categoryImage.image = UIImage(named: "notfound")
    }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "CatalogSegueFromSubcategories", sender: tableView.cellForRow(at: indexPath))
        }
    }

extension SubcategoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.isEmpty {
        // вывод изначального массива
        displayData = subcategories
        } else {
        // поиск по имени товара
        displayData = subcategories.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil }
        }
        tableView.reloadData()
    }
}
