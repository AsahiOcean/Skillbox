import UIKit

class ViewController3: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var ViewInScroll: UIView!
    @IBOutlet weak var ImageFoodScroll: UIScrollView!
    
    // Видимый UIView
    @IBOutlet weak var ViewUp: UIView!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var KitchenType: UILabel!
    @IBOutlet weak var SkidkaText: UILabel!
    @IBOutlet weak var SkindaNubmer: UILabel!
    @IBOutlet weak var RatingNumberLabel: UILabel!
    @IBOutlet weak var CentralTextLabel: UILabel!
    @IBOutlet weak var MenuButton: UIButton!
    @IBOutlet weak var Star: UIImageView!
    @IBOutlet weak var CentalTextLabel2: UILabel!
    @IBOutlet weak var MapView: UIImageView!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    
    // MARK: - Screen & Frames
    
    let ScreenHeight = CGFloat(UIScreen.main.bounds.height)
    let ScreenWidth = CGFloat(UIScreen.main.bounds.width)
    
    lazy var Height = ScreenHeight * 1.75
    lazy var Width = ScreenWidth
    
    lazy var ScrollFoodsHeight = ScreenHeight / 3
    lazy var ScrollFoodsWidth = ScreenWidth
    
    // MARK: - Images Food
    
    var ImagesFoodArray = ["food1", "food2", "food3", "food4", "food5"]
    var Index = 0
    
    lazy var ImageViewHeight = ScrollFoodsHeight
    lazy var ImageViewWidth = ScrollFoodsWidth / 2
    
    lazy var X = CGFloat(0)
    lazy var Y = CGFloat(0)
    
    // Вытаскивает "картинку" из массива и выдает UIImageView с ней
    func FoodDemonstration () -> UIImageView {
        Index += 1
        let ImageFood = UIImageView()
        ImageFood.frame = CGRect(x: X, y: Y, width: ImageViewWidth * 2, height: ImageViewHeight)
        if (UIScreen.main.bounds.height / UIScreen.main.bounds.width) > 1.5 {
            ImageFood.contentMode = .scaleToFill
        } else {
            ImageFood.contentMode = .scaleAspectFill
        }
        ImageFood.image = UIImage.init(named: ImagesFoodArray[Index % ImagesFoodArray.count])
        X += ScreenWidth
        return ImageFood
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print("Высота экрана: \(ScreenHeight)")
        //        print("Ширина экрана: \(ScreenWidth)")
        ViewUp.layer.zPosition = 1
        // Перелистывание картинок в шапке
        ImageFoodScroll.isPagingEnabled = true
    }
    
    // MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        Label.text = "Ресторан 5 звезд Мишлен"
        KitchenType.text = "Универсальная кухня"
        SkindaNubmer.text = "20%"
        RatingNumberLabel.text = "5.0"
        CentralTextLabel.text = "Ресторатор так заморочился, что даже \n картинки в шапке можно полистать"
        CentalTextLabel2.text = "Вроде это барахло неплохо работает \n проверял на 6s, 8+, 11 max и ipad 12.9"
        Star.layer.frame.size = CGSize(width: 42, height: 42)
        
        // Всякие закругления
        ViewUp.layer.cornerRadius = 30
        
        // MARK: - Размер шрифтов
        
        if (UIScreen.main.bounds.height / UIScreen.main.bounds.width) > 1.5 {
            Label.font = UIFont.systemFont(ofSize: 30)
            KitchenType.font = UIFont.systemFont(ofSize: 15)
            SkidkaText.font = UIFont.systemFont(ofSize: 20)
            SkindaNubmer.font = UIFont.systemFont(ofSize: 30)
            RatingNumberLabel.font = UIFont.systemFont(ofSize: 30)
            CentralTextLabel.font = UIFont.systemFont(ofSize: 20)
        } else {
            Label.font = UIFont.systemFont(ofSize: 40)
            KitchenType.font = UIFont.systemFont(ofSize: 25)
            SkidkaText.font = UIFont.systemFont(ofSize: 30)
            SkindaNubmer.font = UIFont.systemFont(ofSize: 40)
            RatingNumberLabel.font = UIFont.systemFont(ofSize: 40)
            CentralTextLabel.font = UIFont.systemFont(ofSize: 40)
        }
        
        // Переопределяем размеры
        ViewInScroll.translatesAutoresizingMaskIntoConstraints = true
        ViewInScroll.layer.frame = CGRect(x: 0, y: 0, width: Width, height: Height)
        ImageFoodScroll.translatesAutoresizingMaskIntoConstraints = true
        ImageFoodScroll.layer.frame = CGRect(x: 0, y: 0, width: ScrollFoodsWidth, height: ScrollFoodsHeight)
        ImageFoodScroll.contentSize = CGSize(width: ScrollFoodsWidth * CGFloat(ImagesFoodArray.count), height: ScrollFoodsHeight)
        
        // Добавляем картинки в скролл в шапке
        for _ in 0...ImagesFoodArray.count - 1 {
            if ScrollFoodsWidth * CGFloat(ImagesFoodArray.count) < X {
                break
            }
            ImageFoodScroll.addSubview(FoodDemonstration())
        }
    }
}
