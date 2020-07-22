import Foundation
import Alamofire
import UIKit
// Skillbox
// Скиллбокс

class Loader {

    func loadCategories(completition: @escaping ([Category]) -> Void){
        AF.request("https://blackstarshop.ru/index.php?route=api/v1/categories").responseJSON{
            response in
            if let objects = response.value, let jsonDict = objects as? [String : Any] {
                let categories = self.getCategories(jsonDict: jsonDict)
                let sortCategories = categories.sorted {
                    item1, item2 in
                    Int(item1.sortOrder)! < Int(item2.sortOrder)!
                }
                DispatchQueue.main.async {
                    completition(sortCategories)
                }
            }
        }
    }
    
    private func getCategories(jsonDict: [String : Any]) -> [Category] {
        var categories: [Category] = []
        
        for (i, value) in jsonDict {
            let categoryJson = value as! [String : Any]
            let id = i
            let name = categoryJson["name"] as! String
            let sortOrder = String(describing: categoryJson["sortOrder"]!)
            let imageLink = categoryJson["image"] as! String
            
            if  let subcategories = categoryJson["subcategories"],
                let subcategoriesArray = subcategories as? [[String : Any]] {
                var subcategoriesResult: [Category] = []
                for item in subcategoriesArray{
                    let subcategoryId = String(describing: item["id"]!)
                    let subcategoryName = item["name"] as! String
                    let subcategorySortOrder = String(describing: item["sortOrder"]!)
                    let subcategoryImageLink = item["iconImage"] as! String
                    
                    let subcategory = Category(id: subcategoryId, name: subcategoryName, imageLink: subcategoryImageLink, sortOrder: subcategorySortOrder, subcategories: nil, image: nil)
                    subcategoriesResult.append(subcategory)
                }
                let category = Category(id: id, name: name, imageLink: imageLink, sortOrder: sortOrder, subcategories: subcategoriesResult, image: nil)
                categories.append(category)
            } else {
                let category = Category(id: id, name: name, imageLink: imageLink, sortOrder: sortOrder, subcategories: nil, image: nil)
                categories.append(category)
            }
        }
        
        return categories
    }
    
    func loadCatalog(categoryId catId: String, completition: @escaping ([Product]) -> Void){
        AF.request("https://blackstarshop.ru/index.php?route=api/v1/products&cat_id=" + catId).responseJSON{
            response in
            
            if let objects = response.value, let jsonDict = objects as? [String : Any] {
                var tempProducts: [Product] = []
                    
                for (i, value) in jsonDict {
                    let id = i
                        
                    guard let productJson = value as? [String : Any] else { return }
                        
                    let name = productJson["name"] as! String
                    let sortOrder = productJson["sortOrder"] as! String
                    let article = productJson["article"] as! String
                    let collection = productJson["collection"] as? String ?? nil
                    let description = productJson["description"] as! String
                    let colorName = productJson["colorName"] as! String
                    let mainImageLink = productJson["mainImage"] as! String
                    var price = productJson["price"] as! String
                    price.removeLast(5)
                    var imagesLinkDict: [String : String] = [:]
                    let productAttributes = productJson["attributes"] as! [[String : String]]
                    let offers = productJson["offers"] as! [[String : String]]
                    
                    let jsonImagesLinks = productJson["productImages"] as! [[String : String]]
                        
                    for dict in jsonImagesLinks {
                        let url = dict["imageURL"]!
                        let sortOrderImage = dict["sortOrder"]!
                        imagesLinkDict[sortOrderImage] = url
                    }
                    
                    let arrayImageOrders = imagesLinkDict.keys.sorted{ $0 > $1}
                    var arrayImageLinks: [String] = []
                    for value in arrayImageOrders {
                        arrayImageLinks.append(imagesLinkDict[value]!)
                    }
                    
                    let product = Product(id: id, name: name, sortOrder: sortOrder, article: article, collection: collection, description: description, colorName: colorName, mainImageLink: mainImageLink, arrayImageLinks: arrayImageLinks, price: price, offers: offers, productAttributes: productAttributes)
                    
                    tempProducts.append(product)
                }
                    
                let products = tempProducts.sorted{
                    item1, item2 in
                    Int(item1.sortOrder)! > Int(item2.sortOrder)!
                }
                
                DispatchQueue.main.async {
                    completition(products)
                }
            }
        }
    }

    func loadImage(link: String, completition: @escaping (UIImage?) -> Void) {
//        var image: UIImage?
        AF.request("https://blackstarshop.ru/" + link).response{
            response in
            guard let data = response.data, let gotImage = UIImage(data: data) else { return }
//            image = gotImage
            DispatchQueue.main.async {
                completition(gotImage)
            }
        }
    }
}
