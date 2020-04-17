import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var ConfigButton: UIButton!
    @IBOutlet weak var Calc: UIButton!
    
// Кнопка "Нажми сюда"
    @IBAction func Button(_ sender: Any) {
        if TextField.text == "" && Label.text == ""  {
            TextField.placeholder = "НУ ХОТЬ ЧТО-НИБУДЬ"
        } else if Label.text == "" {
            Label.text = (Label.text! + " " + TextField.text!)
            TextField.text = ""
            TextField.placeholder = ""
            CleaningButton.layer.isHidden = false
            Calc.layer.isHidden = true
            Back.layer.isHidden = true
        } else if Label.text != nil && TextField.text == "" {
            Label.text = Label.text
            TextField.text = ""
            TextField.placeholder = "Так не работает :)"
            Back.layer.isHidden = true
            Calc.layer.isHidden = true
            CleaningButton.layer.isHidden = false
        } else {
            Label.text = (Label.text! + " " + TextField.text!)
            TextField.text = ""
            TextField.placeholder = ""
            CleaningButton.layer.isHidden = false
            Calc.layer.isHidden = true
            Back.layer.isHidden = true
        }
    }

// Кнопка очистки
    @IBOutlet weak var CleaningButton: UIButton!
    @IBAction func Cleaning(_ sender: Any) {
        Label.text = ""
        TextField.placeholder = "Упс! Напиши еще раз :)"
        ConfigButton.layer.isHidden = true
        Back.layer.isHidden = false
    }

// Кнопка для возвращения на второй экран
    @IBOutlet weak var Back: UIButton!
    
    override func viewDidLoad() {
        Label.text = ""
        TextField.text = ""
        super.viewDidLoad()
        Back.layer.isHidden = true
        Calc.layer.isHidden = false
        
// конфиг кнопки очистки
        ConfigButton.layer.isHidden = true
        ConfigButton.layer.cornerRadius = 10.0
        ConfigButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
}
