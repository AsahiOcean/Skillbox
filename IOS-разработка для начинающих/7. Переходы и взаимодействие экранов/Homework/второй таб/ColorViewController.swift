/*
 второй таб не содержит навигейшн контроллер, в нем есть только лейбл и кнопка «Изменить». В лейбле по умолчанию написано «Выбран зеленый». При нажатии на кнопку происходит переход на следующий экран, где есть текстовое поле, в котором написано «Выбран зеленый» и три кнопки: «Выбрать зеленый», «Выбрать синий», «Выбрать красный». По нажатию на любую из кнопок, этот экран закрывается и на предыдущем должно вывестись в лейбл «Выбран цвет, который только что выбрали».
 При нажатии на кнопку «Изменить» на следующем экране также должен измениться текст лейбла, показывать текущий выбранный цвет и изменять его на новый при нажатии;
 */

import UIKit

protocol Delegator {
    func setColor(_ color: String, colorUI: UIColor?)
}

class ColorViewController: UIViewController {
    
    var ColorOutput = ""
    var delegate: Delegator?
    
    @IBOutlet weak var ColorTextField: UITextField!
    
    @IBAction func Green(_ sender: Any) {
        ColorTextField.text = "ВЫБРАН ЗЕЛЁНЫЙ"
        delegate?.setColor(ColorTextField.text!, colorUI: .green)
        self.dismiss(animated:true, completion: nil)
    }
    @IBAction func Blue(_ sender: Any) {
        ColorTextField.text = "ВЫБРАН СИНИЙ"
        delegate?.setColor(ColorTextField.text!, colorUI: .blue)
        self.dismiss(animated:true, completion: nil)
    }
    @IBAction func Red(_ sender: Any) {
        ColorTextField.text = "ВЫБРАН КРАСНЫЙ"
        delegate?.setColor(ColorTextField.text!, colorUI: .red)
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ColorTextField.text = ColorOutput
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        do { super.touchesEnded(touches, with: event)
            dismiss(animated: true, completion: nil)
            delegate?.setColor(ColorTextField.text!, colorUI: nil)
        }
    }
}
// Skillbox
// Скиллбокс
