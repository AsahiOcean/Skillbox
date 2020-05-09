import UIKit
import RealmSwift
import Alamofire

class EmailVC: UIViewController {
    @IBOutlet weak var enter: UIButton!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Pass: UITextField!
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    var rateResult: Results<BitCoinObject>!
    
    @IBAction func FacebookTrue(_ sender: Any) {
    let userinfo = self.realm.objects(UserInfo.self)
    if let userinfo = userinfo.first {
        try! self.realm.write {
        userinfo.facebook = true
/* https://developers.facebook.com/docs/facebook-login/overview/?locale=ru_RU
*/
    }}}
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
    let userinfo = self.realm.objects(UserInfo.self)
    if (userinfo.first?.email.isEmpty)! { self.EmailPassGen()
    } else { self.EmailLogin() }
    
    // Периферия
    enter.layer.cornerRadius = 10
    self.view.addSubview(BackgroundVideo())
    }
    
    fileprivate func EmailLogin() {
    let userinfo = self.realm.objects(UserInfo.self)
    asyncAfter(1.0) {
        self.Email.text?.append("\(userinfo.first!.email)")
    asyncAfter(1.0) {
        self.Pass.text?.append("\(userinfo.first!.pass)")
        self.enter.alpha = 1.0;
    asyncAfter(0.5) { self.GoToLists() }
    }}}
    
    /// Имитация ввода данных пользователем
    fileprivate func EmailPassGen() {
    EmailGen(TF: self.Email)
    let userinfo = self.realm.objects(UserInfo.self)
    asyncAfter(2.5) {
        if let userinfo = userinfo.first { try! self.realm.write {
        userinfo.email = "\(self.Email.text!)" }
        PassGen(TF: self.Pass)
    asyncAfter(2.5) {
        let userinfo = self.realm.objects(UserInfo.self)
        if let userinfo = userinfo.first { try! self.realm.write {
        userinfo.pass = "\(self.Pass.text!)"
        self.enter.alpha = 1.0
    asyncAfter(0.5) { self.GoToLists() }
    }}}}}}
    
    private func GoToLists() {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListsNC")
    self.definesPresentationContext = true
    vc?.modalPresentationStyle = .overCurrentContext
    self.present(vc!, animated: true, completion: nil)
    /*
    при успешной авторизации, можно начать подгружать какие-нибудь
    данные со сторонних ресурсов, например курс и новости
    */
    NewsArray()
    BitcoinRate()
    }
}
