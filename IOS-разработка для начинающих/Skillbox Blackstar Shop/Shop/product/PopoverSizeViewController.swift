//
//  PopoverSizeViewController.swift
//  Shop
//
//  Created by Serg Fedotov on 01.05.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import UIKit

class PopoverSizeViewController: UIViewController {

    @IBOutlet weak var sizeView: UIView!
    
    var product: Product? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
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
        if let product = self.product, let offers = product.offers {
            let buyItem = ProductObject()
            buyItem.getData(id: product.id, name: product.name, colorName: product.colorName, mainImageLink: product.mainImageLink, price: product.price, size: offers[indexPath.row]["size"] ?? "")
            Persistance.shared.save(item: buyItem)
        }
        removeAnimate()
    }
    
    func showAnimate(){
        self.view.transform = .init(translationX: 0, y: self.view.bounds.height)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1
            self.view.transform = .init(translationX: 0, y: 0)
        })
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = .init(translationX: 0, y: self.view.bounds.height)
            self.view.alpha = 0.0
        }, completion: {
            finished in
            if finished {
                self.view.removeFromSuperview()
            }
        })
    }
}
