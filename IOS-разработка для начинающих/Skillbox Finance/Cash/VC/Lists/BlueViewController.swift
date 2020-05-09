import UIKit

class SearchExample: UIViewController {
        
        @IBOutlet weak var searchBar: UISearchBar!
        @IBOutlet weak var tableView: UITableView!
        
        let data: [String] = ["Hello", "World", "Disnay", "Diary", "Supreme", "Member", "Memory", "Critical", "System"]
        var displayData: [String] = [String]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            displayData = data
        }
    }

extension SearchExample: UITableViewDelegate, UITableViewDataSource {
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")// as? UITableViewCell
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            
            cell?.textLabel?.text = displayData[indexPath.row]
            return cell!
        }
        
        public func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return displayData.count
        }
    }

extension SearchExample: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            displayData = data.filter { $0.range(of: searchText, options: .caseInsensitive) != nil }
            tableView.reloadData()
        }
    }
