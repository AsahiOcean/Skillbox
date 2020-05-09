//
//  BasketViewController.swift
//  Shop
//
//  Created by Serg Fedotov on 01.05.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func goNextScreen(_ sender: UIButton) {
        if toMain {
            let vc = storyboard!.instantiateViewController(identifier: "MainScreen"); show(vc, sender: nil)
    }}
    
    private var items = Persistance.shared.getItems()
    private var images: [UIImage] = []
    private var toMain = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderButton.layer.cornerRadius = 10
        addImage(); sum()
    }
        
    private func sum(){
        var sum = 0
        for item in items {
            sum += Int(item.price) ?? 0
        }; priceLabel.text = String(sum)  + " ₽"
        
        if sum == 0 {
            orderButton.isEnabled = false
            orderButton.alpha = 0.5
        } else {
            toMain = true
            orderButton.isEnabled = true
        }
    }
    
    private func addImage(){
        for index in self.items.indices {
            Loader().loadImage(link: self.items[index].mainImageLink) {
                gotImage in
                if let image = gotImage {
                    self.images.append(image)
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
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
        cell.delegate = self
        return cell
    }
}

extension BasketViewController: BasketTableViewCellDelegate {
    func basketTableViewCell(_ bascketTableViewCell: BasketTableViewCell, indexPath: IndexPath) {
        
        let popover = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DeletePopover") as! DeletePopoverViewController
        self.addChild(popover)

        popover.view.frame = CGRect(x: .zero, y: .zero, width: self.view.frame.width, height: self.view.frame.height)
        
        popover.indexPath = indexPath
        popover.delegate = self
        
        self.view.addSubview(popover.view)
        popover.didMove(toParent: self)
    }
}

extension BasketViewController: DeletePopoverViewControllerDelegate {
    func deleteItem(indexPath: IndexPath) {
        Persistance.shared.remove(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        sum()
    }
}
