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

class ViewController: UIViewController {
    
    @IBOutlet weak var BackButtonOutlet: UIButton!
    @IBOutlet weak var NextButtonOutlet: UIButton!
    @IBOutlet weak var Viewer: UIImageView!
    
    // Определяем размеры экрана
    let ScreenSize: CGRect = UIScreen.main.bounds
    
    // Массив картинок
    var Images = ["image1","image2","image3","image4","image5","image6","image7","image8","image9","image10"]
    
    // Начальный "индекс"
    var Index = 0
    
    @IBAction func BackButton(_ sender: Any) {
        // Бесконечная прокрутка назад
        if Index == 0 {
            Index = Images.count - 1
            Viewer.image = UIImage.init(named: Images[Index % Images.count])
        } else {
            Index -= 1
            Viewer.image = UIImage.init(named: Images[Index % Images.count])
        }
    }
    
    @IBAction func NextButton(_ sender: Any) {
        // Бесконечная прокрутка вперед
        if Index < Images.count {
            Index += 1
            Viewer.image = UIImage.init(named: Images[Index % Images.count])
        } else {
            Index = 0
            Index += 1
            Viewer.image = UIImage.init(named: Images[Index % Images.count])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // При запуске показать первую картинку из массива Images
        Viewer.image = UIImage.init(named: Images[0])
        
        // Показываем картинку на весь экран
        Viewer.frame = ScreenSize
        Viewer.contentMode = .scaleAspectFill
        
        // Кнопки поверх всех элементов на экране
        BackButtonOutlet.layer.zPosition = 1
        NextButtonOutlet.layer.zPosition = 1
    }
}
