/*
Для всех задач сделайте один проект с одним экраном, где будет кнопки «предыдущая» и «следующая» внизу экрана, а между ними – номер текущей анимации. Этими кнопками можно выбрать нужную анимацию. Номер анимации – это номер задачи из списка ниже. Все анимации применяются к красному квадрату наверху экрана. Все анимации суммарно длятся две секунды (кроме последней) и после завершения возвращают квадрат в тоже состояние, что он был до анимации. Итак, сделайте следующие анимации:

Изменение цвета фона квадрата на желтый
Перемещение в правый верхний угол экрана
Закругление краев, чтобы он выглядел как круг
Поворот на 180 градусов
«Исчезание»
Сначала увеличение в два раза, потом анимированное уменьшение обратно
Бесконечную анимацию поворота
 
*/

import UIKit
import SVProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var ObjectView: UIView!

    var number = 0
    let ColorExperiment = UIColor.systemRed
    
    let timeAnimation: TimeInterval = 2.0 / 7

    func Animation(number: Int) {
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(UIColor.green)
        switch number {
            case 0:
                self.ObjectView.layer.removeAllAnimations()
                self.ObjectView.center = self.view.center
                UIView.animate(withDuration: 0.5, delay: 0, options: .allowAnimatedContent, animations: {
                    self.ObjectView.backgroundColor = self.ColorExperiment
                })
                numberLabel.text = " "
            case 1:
                UIView.animate(withDuration: timeAnimation, delay: 0, options: .autoreverse, animations: {
                    self.ObjectView.backgroundColor = self.ColorExperiment
                }, completion: { _ in
                    self.ObjectView.backgroundColor = UIColor.systemYellow
                })
                numberLabel.text = "Анимация №1"
            case 2:
                UIView.animate(withDuration: timeAnimation, delay: 0, options: .autoreverse, animations: {
                    self.ObjectView.frame.origin.x += (self.view.frame.width - self.ObjectView.frame.width) / 2
                    self.ObjectView.frame.origin.y -= (self.view.frame.height - self.ObjectView.frame.height) / 2
                }, completion: { _ in // при завершении возвращаем обратно
                    self.ObjectView.center = self.view.center
                })
                numberLabel.text = "Анимация №2"
            case 3:
                UIView.animate(withDuration: timeAnimation, delay: 0, options: .autoreverse, animations: {
                    self.ObjectView.layer.cornerRadius = self.ObjectView.frame.width / 2
                }, completion: { _ in
                    self.ObjectView.layer.cornerRadius = 0
                })
                numberLabel.text = "Анимация №3"
            case 4:
                UIView.animate(withDuration: timeAnimation, delay: 0, options: .allowAnimatedContent, animations: {
                    self.ObjectView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                }, completion: { _ in
                    self.ObjectView.transform = CGAffineTransform(rotationAngle: 0)
                })
                numberLabel.text = "Анимация №4"
            case 5:
                self.ObjectView.center = self.view.center
                UIView.animate(withDuration: timeAnimation, delay: 0, options: .autoreverse, animations: {
                    self.ObjectView.alpha = 0
                }, completion: { _ in
                    self.ObjectView.alpha = 1
                })
                numberLabel.text = "Анимация №5"
            case 6:
                UIView.animate(withDuration: timeAnimation, delay: 0, options: .autoreverse, animations: {
                    self.ObjectView.transform = CGAffineTransform(rotationAngle: 0)
                    self.ObjectView.frame.size = CGSize(width: self.ObjectView.frame.size.width * 2, height: self.ObjectView.frame.size.height * 2)
                    self.ObjectView.center = self.view.center
                }, completion: { _ in
                    self.ObjectView.frame.size = CGSize(width: self.ObjectView.frame.size.width / 2, height: self.ObjectView.frame.size.height / 2)
                    self.ObjectView.center = self.view.center
                })
                numberLabel.text = "Анимация №6"
            case 7:
                UIView.animate(withDuration: timeAnimation, delay: 0, options: .repeat, animations: {
                    self.ObjectView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                }, completion: nil)
                numberLabel.text = "Анимация №7"
        default:
                break
        }
        SVProgressHUD.dismiss(withDelay: 1)
    }

    @IBAction func previousTap(_ sender: Any) {
        if number >= 1 {
            number -= 1
        }
        Animation(number: number)
    }
    
    @IBAction func nextTap(_ sender: Any) {
        if  number < 7 {
            number += 1
            Animation(number: number)
        } else {
            number = 0
            Animation(number: number)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = " "
        numberLabel.frame.size.width = view.frame.size.width
        numberLabel.textAlignment = .center
        ObjectView.backgroundColor = ColorExperiment
        ObjectView.center = view.center
    }
}
