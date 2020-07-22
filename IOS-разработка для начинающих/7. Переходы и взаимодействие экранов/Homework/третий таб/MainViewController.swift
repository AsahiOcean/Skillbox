import UIKit

class MainViewController: UIViewController {
    
    var dvc: EmbedViewController?

    @IBAction func ButtonMainYellow(_ sender: Any) {
        dvc?.view.backgroundColor = .yellow
    }
    
    @IBAction func ButtonMainGreen(_ sender: Any) {
        dvc?.view.backgroundColor = .green
    }
    
    @IBAction func ButtonMainPurple(_ sender: Any) {
        dvc?.view.backgroundColor = .purple
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EmbedViewController, segue.identifier == "EmbedSegue" {
            vc.EmbedDelegator = self
            dvc = vc.self
        }
    }
}
extension MainViewController: EmbedDelegateProtocol {
    func ColorMainBackground(_ ColorOutEmbed: UIColor?) {
        self.view.backgroundColor = ColorOutEmbed
        
    }
}
// Skillbox
// Скиллбокс
/*
 Создать таб бар контроллер, у которого три таба:

 первый таб содержит в себе навигейшн контроллер, в котором есть три кнопки: «Зеленый», «Синий» и «Красный». По нажатию на эти кнопки происходит переход на экран с таким же цветом фона, как и у названия кнопки;

 второй таб не содержит навигейшн контроллер, в нем есть только лейбл и кнопка «Изменить». В лейбле по умолчанию написано «Выбран зеленый». При нажатии на кнопку происходит переход на следующий экран, где есть текстовое поле, в котором написано «Выбран зеленый» и три кнопки: «Выбрать зеленый», «Выбрать синий», «Выбрать красный». По нажатию на любую из кнопок, этот экран закрывается и на предыдущем должно вывестись в лейбл «Выбран цвет, который только что выбрали».
 При нажатии на кнопку «Изменить» на следующем экране также должен измениться текст лейбла, показывать текущий выбранный цвет и изменять его на новый при нажатии;

 третий таб содержит в себе контроллер, в который встроен другой контроллер. И у родительского, и дочернего контроллеров есть три кнопки: «Зеленый», «Желтый», «Пурпурный». При нажатии на одну из кнопок в родительском контроллере, фоновый цвет дочернего контроллера изменяется на соответствующий, при нажатии на кнопку в дочернем — изменяется фон у родительского.
*/
