import UIKit

/*
 1. Сделать проект-галерею: большой UIImageView и под ним две кнопки: «Назад» и «Дальше».
 
 2. Добавить в проект 10 картинок. По нажатию на кнопки должна показываться соответственно предыдущая или следующая картинка.
 
 3. Используя цикл, сгенерировать на экране четыре UIImageView и лейбла, как показано на изображении (приложено ниже). Дополнительные элементы генерировать не нужно.
 
 4. Разобраться с UISegmentedControl: пусть она будет иметь три сегмента, и, в зависимости от выбранного сегмента, под ним показывается:
 
 первый сегмент — зеленая вью с двумя текстовыми полями;
 второй сегмент — синяя вью с двумя кнопками;
 третий сегмент — фиолетовая вью с двумя картинками.
 */

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var Blur: UIVisualEffectView!
    //  Размеры экрана
    let ScreenHeight = Int(UIScreen.main.bounds.size.height) // Высота экрана
    let ScreenWidth = Int(UIScreen.main.bounds.size.width) // Ширина экрана
    //  Отступ у экрана
    lazy var YFooter = (ScreenHeight / 100) * 3 // Сверху
    lazy var XFooter = (ScreenWidth / 100) * 5 // Слева
    //  Начальные размеры SafeArea
    lazy var SafeAreaHeight = ScreenHeight - (YFooter * 2) // по высоте + вычитаем отступ
    lazy var SafeAreaWidth = ScreenWidth - (XFooter * 2) // по ширине + вычитаем отступ
    
    //  Начальные координаты картинки
    lazy var Y = YFooter // по высоте
    lazy var X = XFooter // по ширине
    
    //  Расстояние между картинками / Отступ между картинками
    lazy var DistanceImageHeight = (SafeAreaHeight / 100) * 5 // по высоте
    lazy var DistanceImageWidth = (SafeAreaWidth / 100) * 5 // по ширине
    
    //  Размеры картинок
    lazy var ImageHeight = (SafeAreaHeight / 100) * 40 // По высоте
    lazy var ImageWidth = (SafeAreaWidth / 100) * 60 // По ширине
    
    var Images = ["image1","image2","image3","image4","image5","image6","image7","image8","image9","image10"]
    var Index = 0
    
    func Separator() {
        if X < SafeAreaWidth {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: X, y: Y, width: ImageWidth, height: ImageHeight)
            imageView.image = UIImage.init(named: Images[Index % Images.count])
            view.addSubview(imageView)
            // Написать лейбл картинки
            let ImageName = UILabel(frame: CGRect(x: X, y: Y+ImageHeight, width: ImageWidth, height: 25))
            ImageName.textColor = .white
            ImageName.font = .systemFont(ofSize: 20)
            ImageName.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            ImageName.textAlignment = .center
            ImageName.text = ("Filename: \(Images[Index % Images.count])")
            self.view.addSubview(ImageName)
            //  Добавить индекс и координты по ширине
            Index += 1
            X += (ImageWidth + DistanceImageWidth)
        } else if X > SafeAreaWidth {
            //              print("НЕ ВЛЕЗАЕМ ПО ШИРИНЕ! ИДЕМ НИЖЕ!")
            Index -= 1 // без этого пропускает image3
            X = XFooter // Отступ от края экрана
            Y += ImageHeight + DistanceImageHeight // Прибавить к Y высоту картинки и отступ
            let Viewer = UIImageView()
            Viewer.image = UIImage.init(named: Images[Index % Images.count])
            Viewer.frame = CGRect(x: X, y: Y, width: ImageWidth, height: ImageHeight)
            view.addSubview(Viewer)
            Index += 1
        } else {
            print("ЧТО-ТО НЕ ТАК!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0...Images.count - 1 {
            Separator()
        }
        //            SafeArea()
        print("Высота экрана: \(ScreenHeight) [ScreenHeight]")
        print("Ширина экрана: \(ScreenWidth) [ScreenWidth]\n")
        print("Отступ по Y: \(YFooter) [YFooter]")
        print("Отступ по X: \(XFooter) [XFooter]\n")
        print("SafeArea по высоте: \(SafeAreaHeight) [SafeAreaHeight]")
        print("SafeArea по ширине: \(SafeAreaWidth) [SafeAreaWidth]\n")
        print("Расстояние между картинками по высоте: \(DistanceImageHeight) [DistanceImageHeight]")
        print("Расстояние между картинками по ширине: \(DistanceImageWidth) [DistanceImageWidth]\n")
        print("Начальные координаты КАРТИНКИ по Y: \(Y)")
        print("Начальные координаты КАРТИНКИ по X: \(X)\n")
        print("ВЫСОТА КАРТИНКИ: \(ImageHeight) [ImageHeight]")//" = \(SafeHeight) - (\(DistanceImageHeight) * 2)")
        print("ШИРИНА КАРТИНКИ: \(ImageWidth) [ImageWidth]")//" = \(SafeWidth) - (\(DistanceImageWidth) * 2) \n")
        print("- - - - - - - - - - - - - - - - - - - - - -")
        
        Blur.layer.zPosition = 1
    }
}
