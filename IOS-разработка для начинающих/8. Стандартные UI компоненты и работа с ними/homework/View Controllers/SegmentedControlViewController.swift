import UIKit
// Skillbox
// Скиллбокс
/*
 1. Сделать проект-галерею: большой UIImageView и под ним две кнопки: «Назад» и «Дальше».

 2. Добавить в проект 10 картинок. По нажатию на кнопки должна показываться соответственно предыдущая или следующая картинка.

 3. Используя цикл, сгенерировать на экране четыре UIImageView и лейбла, как показано на изображении (приложено ниже). Дополнительные элементы генерировать не нужно.

 4. Разобраться с UISegmentedControl: пусть она будет иметь три сегмента, и, в зависимости от выбранного сегмента, под ним показывается:

первый сегмент — зеленая вью с двумя текстовыми полями;
второй сегмент — синяя вью с двумя кнопками;
третий сегмент — фиолетовая вью с двумя картинками.
*/

class SegmentedControlViewController: UIViewController {

    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var View3: UIView!
    
    
    @IBAction func Segmetes(_ sender: Any) {
        switch SegmentedControl.selectedSegmentIndex {
        case 0:
            View1.layer.isHidden = false
            View2.layer.isHidden = true
            View3.layer.isHidden = true
        case 1:
            View1.layer.isHidden = true
            View2.layer.isHidden = false
            View3.layer.isHidden = true
        case 2:
            View1.layer.isHidden = true
            View2.layer.isHidden = true
            View3.layer.isHidden = false
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        View1.layer.isHidden = false
        View2.layer.isHidden = true
        View3.layer.isHidden = true
    }
}
