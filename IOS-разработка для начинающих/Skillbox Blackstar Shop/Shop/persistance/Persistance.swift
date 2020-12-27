import Foundation
import RealmSwift

class Persistance {
    static let shared = Persistance()
    
    private let realm = try! Realm()
    
    func save(item: ProductObject){
        try! realm.write {
            realm.add(item)
        }
    }
    
    func getItems() -> Results<ProductObject> {
        realm.objects(ProductObject.self)
    }
    
    func remove(index: Int){
        let item = realm.objects(ProductObject.self)[index]
        try! realm.write {
            realm.delete(item)
        }
    }
}
