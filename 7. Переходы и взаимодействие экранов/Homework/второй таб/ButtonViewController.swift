/*
 второй таб не содержит навигейшн контроллер, в нем есть только лейбл и кнопка «Изменить». В лейбле по умолчанию написано «Выбран зеленый». При нажатии на кнопку происходит переход на следующий экран, где есть текстовое поле, в котором написано «Выбран зеленый» и три кнопки: «Выбрать зеленый», «Выбрать синий», «Выбрать красный». По нажатию на любую из кнопок, этот экран закрывается и на предыдущем должно вывестись в лейбл «Выбран цвет, который только что выбрали».
 При нажатии на кнопку «Изменить» на следующем экране также должен измениться текст лейбла, показывать текущий выбранный цвет и изменять его на новый при нажатии;
 */

import UIKit

class ButtonViewController: UIViewController {

    @IBOutlet weak var ConfigButton: UIButton!
    
    @IBOutlet weak var ColorLabel: UILabel!
    var ColorName = "Выбран зелёный"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ColorLabel?.text = ColorName
        ConfigButton.layer.cornerRadius = 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ColorViewController, segue.identifier == "Show" {
            vc.ColorOutput = ColorLabel.text!
            vc.delegate = self
            }
    }
}

extension ButtonViewController: Delegator {
    func setColor(_ color: String, colorUI: UIColor?) {
        ColorLabel.text = "\(color)"
        if let colorUI = colorUI {
            ConfigButton.layer.backgroundColor = colorUI.cgColor
        }
    }
}
