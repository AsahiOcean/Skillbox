/*
 3.  Сделайте сворачивающийся/разворачивающийся текст по нажатию кнопки: у лейбла стоит ограничение в 0 строк и констрейнта по высоте. По нажатию на кнопку эта констрейнта последовательно меняется на высоту одной строки лейбла и на высоту 5 строк.
 */

import UIKit

class ViewControllerTask3: UIViewController {

    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var WidthLabel: NSLayoutConstraint!
    @IBOutlet weak var HeightLabel: NSLayoutConstraint!
    @IBOutlet weak var Button: UIButton!
    
    let ScreenHeight = Int(UIScreen.main.bounds.size.height) // Высота экрана
    let ScreenWidth = Int(UIScreen.main.bounds.size.width) // Ширина экрана
    let FontSize = CGFloat(20)
    
    @IBAction func Button(_ sender: Any) {
        if Label.text == "" {
            HeightLabel.constant = FontSize + 10 // высота лейбла +1 FontSize
            WidthLabel.constant = CGFloat((ScreenWidth / 10) * 9)
            Label.text! += Heading // пишем заголовок
            Button.setTitle("Показать полностью?", for: .normal)
            print("Показал заголовок")
            Memory = "ShowHeading" // в переменную
        } else if Memory == "ShowHeading" {
            Label.text! += "\n" // начать с новой строки
            HeightLabel.constant += FontSize * 5 // +5 размеров текста
            Label.text! += FishText // написать текст-рыбу
            Button.setTitle("Свернуть обратно?", for: .normal)
            print("Написал текст")
            Memory = "ShowFishText" // в переменную
        } else if Memory == "ShowFishText" {
            Label.text! = Heading // оставить заголовок
            HeightLabel.constant -= FontSize * 5 // уменьшить область
            print("Убираем текст")
            Memory = "HideFishText" // в переменную
            Button.setTitle("Свернуть совсем?", for: .normal)
        } else if Memory == "HideFishText" {
            Label.text = "" // убрать всё
            WidthLabel.constant = 0
            HeightLabel.constant = 0
            Button.setTitle("Показать снова?", for: .normal)
        }
    }
    
    var Memory = ""
    
    var Heading = "ЗАГОЛОВОК"
    
    var FishText = "Равным образом реализация намеченных плановых заданий представляет собой интересный эксперимент проверки систем массового участия. Повседневная практика показывает, что консультация с широким активом требуют определения и уточнения систем массового участия. Значимость этих проблем настолько очевидна, что начало повседневной работы по формированию позиции требуют определения и уточнения модели развития.Не следует, однако забывать, что реализация намеченных плановых заданий требуют от нас анализа новых предложений. Задача организации, в особенности же начало повседневной работы по формированию позиции требуют определения и уточнения существенных финансовых и административных условий. Повседневная практика показывает, что укрепление и развитие структуры влечет за собой процесс внедрения и модернизации системы обучения кадров, соответствует насущным потребностям."

    override func viewDidLoad() {
        super.viewDidLoad()
        Label.text = ""
        Label.font.withSize(FontSize)
        Label.numberOfLines = 0
        Button.setTitle("Показать новость", for: .normal)
    }
}
