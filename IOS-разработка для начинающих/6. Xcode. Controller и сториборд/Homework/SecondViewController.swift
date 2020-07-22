/*
Если в текстовом поле не введено целое число, то «Введите целое число в строку».

Для этой задачи нужно будет сделать три текстовых поля. По сути — это аналог калькулятора. В первое поле вводится целое число, во второе — оператор (минус, плюс, умножить, делить), в третье поле — второе число. При нажатии на кнопку, операция из второго поля применяется к числу из первого и третьего поля. Если где-то введены некорректные данные, в лейбл должно вывестись «Некорректные данные».
*/
// Skillbox
// Скиллбокс

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var TextField1: UITextField!
    @IBOutlet weak var TextField2: UITextField!
    @IBOutlet weak var TextField3: UITextField!
    @IBOutlet weak var Boost: UIButton!
    @IBOutlet weak var Boost2: UIButton!
    
    @IBAction func Result(_ sender: Any) {
        if (TextField1.text?.contains("."))! || (TextField1.text?.contains(","))! || (TextField3.text?.contains("."))! || (TextField3.text?.contains(","))! {
            Label.text = "Введите целое число в строку" }
        else if Int(TextField1.text!) != nil && Int(TextField3.text!) != nil && TextField2.text == "-" {
            let value = Int(TextField1.text!)!
            let value2 = Int(TextField3.text!)!
            let toString = String(value - value2)
            self.Label.text = toString }
        else if Int(TextField1.text!) != nil && Int(TextField3.text!) != nil && TextField2.text == "+" {
            let value = Int(TextField1.text!)!
            let value2 = Int(TextField3.text!)!
            let toString = String(value + value2)
            self.Label.text = toString }
        else if Int(TextField1.text!) != nil && Int(TextField3.text!) != nil && TextField2.text == "*" {
            let value = Int(TextField1.text!)!
            let value2 = Int(TextField3.text!)!
            let toString = String(value * value2)
            self.Label.text = toString }
        else if Int(TextField1.text!) != nil && Int(TextField3.text!) != nil && TextField2.text == "/" {
            let value = Int(TextField1.text!)!
            let value2 = Int(TextField3.text!)!
            let toString = String(value / value2)
            self.Label.text = toString }
        else {
            Label.text = "Некорректные данные"
            }
        }

    @IBAction func Left(_ sender: Any) {
        if (TextField1.text?.contains("."))! || (TextField1.text?.contains(","))! || (TextField3.text?.contains("."))! || (TextField3.text?.contains(","))! {
            Label.text = "Введите целое число в строку" }
        else if Int(TextField1.text!) != nil {
            let value = Int(TextField1.text!)!
            if value >= 63 {
                Label.text = "ЭТО ОЧЕНЬ МНОГО!!!"
            } else {
                let toString = String(1 << value)
                self.Label.text = toString
            }
        } else {
            Label.text = "Некорректные данные"
        }
}
    
    @IBAction func Right(_ sender: Any) {
        if (TextField1.text?.contains("."))! || (TextField1.text?.contains(","))! || (TextField3.text?.contains("."))! || (TextField3.text?.contains(","))! {
            Label.text = "Введите целое число в строку" }
        else if Int(TextField3.text!) != nil {
            let value = Int(TextField3.text!)!
                if value >= 63 {
                    Label.text = "ЭТО ОЧЕНЬ МНОГО!!!"
                } else {
                    let toString = String(1 << value)
                    self.Label.text = toString
                }
        } else {
            Label.text = "Некорректные данные"
        }
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
        }
}
