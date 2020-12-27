import UIKit
import RealmSwift

class ProfileVC3: UIViewController {
    @IBOutlet weak var Login: UILabel!
    @IBOutlet weak var Photo: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var Pourboire: UIButton!
    @IBOutlet weak var CartNum: UILabel!
    
    @IBAction func Exit(_ sender: Any) {
        let Login = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.definesPresentationContext = true
        Login?.modalPresentationStyle = .overFullScreen
        self.present(Login!, animated: true, completion: nil)
        self.removeFromParent()
        //        exit(0)
    }
    
    @IBAction func Get(_ sender: Any) {
        let userinfo = self.realm.objects(UserInfo.self)
        if let userinfo = userinfo.first {
            try! self.realm.write {
                userinfo.pourboire += self.pourboire
            }
        }; print(userinfo)
        pourboire = 0
        Pourboire.setTitle("Запрос отправлен!", for: .normal)
        Pourboire.backgroundColor = .systemGreen
        
        
        let refillViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "refillViewController") as! refillViewController
        self.addChild(refillViewController)
        
        refillViewController.view.frame = CGRect(x: 0, y: self.view.frame.minY + 100, width: view.frame.width, height: 200)
        
        self.view.addSubview(refillViewController.view)
        refillViewController.didMove(toParent: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.children.count > 0 {
                let viewControllers:[UIViewController] = self.children
                for viewContoller in viewControllers{
                    viewContoller.willMove(toParent: nil)
                    viewContoller.view.removeFromSuperview()
                    viewContoller.removeFromParent()
                }
            }}
    }
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    var pourboire = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userinfo = self.realm.objects(UserInfo.self)
        Login.text = "\(userinfo.first!.login)"
        Name.text = "\(userinfo.first!.name)"
        CartNum.text = "Карта *\(userinfo.first!.mobile.suffix(5).filter { $0 != "-" })"
        Pourboire.layer.cornerRadius = 20
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            let plus = Int.random(in: 100..<500)
            self.pourboire = self.pourboire + plus
            self.Pourboire.setTitle("Получить чаевые \(self.pourboire)", for: .normal)
            self.Pourboire.backgroundColor = .systemBlue
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}
