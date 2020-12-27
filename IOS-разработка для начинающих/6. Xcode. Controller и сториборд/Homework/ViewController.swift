import UIKit

/*
 1. Прочитайте лучшие практики и анализ плюсов и минусов в сторибордах.
 https://habr.com/ru/company/mobileup/blog/456086/
 
 2. Создайте следующие проекты, в каждом из которых есть одно текстовое поле, кнопка и лейбл. При нажатии на кнопку в лейбл выводится:
 
 текущее значение текстфилда и все предыдущие, для которых была нажата кнопка. Разделитель — пробел. Например, в поле ввели «Никита», нажали кнопку — в лейбл выведется «Никита». В поле ввели «Антон» и нажали на кнопку — в лейбл должно вывестись «Антон Никита» и тд.
 если в текстовое поле введено целое число, то значение 2 в степени числа из текстового поля; если в текстовом поле не введено целое число, то «Введите целое число в строку».
 Для этой задачи будет нужно сделать три текстовых поля. По сути это аналог калькулятора :) в первое поле вводится целое число, во второе — оператор (минус, плюс, умножить, делить), в третье поле — второе число. При нажатии на кнопку операция из второго поля применяется к числу из первого и третьего поля. Если где-то введены некорректные данные, в лейбл должно вывестись «Некорректные данные».
 
 Ссылка на UIViewController
 https://developer.apple.com/documentation/uikit/uiviewcontroller
 */

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
