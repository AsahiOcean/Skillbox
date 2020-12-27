import Foundation
import RealmSwift

class Persistance {
    static let shared = Persistance()
    private let realm = try! Realm()
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    // MARK: UserInfo
    func add(info: String){
        let info = UserInfo()
        try! realm.write
        { realm.add(info) } }
    
    func getinfos() -> Results<UserInfo>
    { realm.objects(UserInfo.self) }
    
    func removeInfo(index: Int){
        let info = realm.objects(UserInfo.self)[index]
        try! realm.write { realm.delete(info) }}
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    // MARK: ProductObject
    func saveProduct(item: ProductObject){
        try! realm.write { realm.add(item) }}
    
    func getProducts() -> Results<ProductObject>
    { realm.objects(ProductObject.self) }
    
    func removeProduct(index: Int){
        let item = realm.objects(ProductObject.self)[index]
        try! realm.write { realm.delete(item) }}
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    // MARK: HistoryProduct
    func saveHistoryProduct(item: HistoryProduct){
        try! realm.write { realm.add(item) }}
    
    func getItemsHistory() -> Results<HistoryProduct>
    { realm.objects(HistoryProduct.self) }
    
    func removeHistoryProduct(index: Int){
        let item = realm.objects(HistoryProduct.self)[index]
        try! realm.write { realm.delete(item) }}
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    // MARK: BitCoinRate
    func addBitCoinRate(){
        let rate = BitCoinObject()
        try! realm.write { realm.add(rate) } }
    
    func saveBitCoinRate(rate: BitCoinObject){
        try! realm.write { realm.add(rate) }}
    
    func getBitCoinRate() -> Results<BitCoinObject>
    { realm.objects(BitCoinObject.self) }
}
