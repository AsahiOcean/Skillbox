import UIKit
/*
1) Написать, какие 4 ценности есть в манифесте Agile (своими словами).
//MARK: см. Agile.md

2) В чем отличия скрама от канбана? Написать минимум 3.
//MARK: см. ScrumVsKanban.md

3) Описать процесс работы по скраму.
//MARK: см. ScrumProcess.md
 
4) Прочитать статью про тестирование.
https://www.raywenderlich.com/960290-ios-unit-testing-and-ui-testing-tutorial

5) Создать проект, сделать в нем модель с функцией валидации логина (почты) и пароля:
    логин должен быть корректной почтой,
    пароль – не меньше 6 символов,
        содержать как минимум одну цифру, одну букву в нижнем регистре и одну – в верхнем.
 
 При ошибке должна возвращать ошибку (если есть) или успех.
 
 Сделать экран для ввода логина и пароля, где кнопка “войти” становится активной, если поле логина и поле пароля не пустые.
 // до этого она должна быть неактивной??
 
 При нажатии на кнопку в случае ошибки должна показываться надпись с текстом ошибки, в случае успеха – показываться следующий экран с поздравлением.
 
 Сделать следующие тесты:
        1) корректность работы функции проверки логина и пароля (не менее 8 проверок).
        2) корректность обработки неправильных данных в интерфейсе (UI тесты), не менее 3 сценариев.
        3) корректность обработки правильных данных в интерфейсе.

6) Интегрировать проект с любым CI/CD сервисом (например Bitrise).
*/

class ViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var message: UILabel!
    
    @IBAction func loginEdit(_ sender: UITextField) {
        if sender.text?.isEmpty == false { loginButtonEnabled() }

        /*
        guard let email = sender.text else { return }
        if email.count < 3 {
            message.text?.removeAll()
        } else {
            if validateEmail(candidate: email) {
                message.text = "success"
            } else {
                message.text = "error"
            }
        }
        */
    }
    
    @IBAction func passEdit(_ sender: UITextField) {
        if sender.text?.isEmpty == false { loginButtonEnabled() }

        /*
        guard let pass = sender.text else { return }
        if pass.count > 0 {
            if validatePassword(candidate: pass) {
                message.text = "success"
            } else {
                message.text = "Enter min 6 sym include 1 upper, 1 lowercase character and 1 num"
            }
        } else {
            message.text?.removeAll()
        }
         */
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let email = loginTextField.text else { return }
        guard let pass = passTextField.text else { return }
        
        if validateEmail(candidate: email) {
            message.text = "success"
            if pass.count > 0 {
                if validatePassword(candidate: pass) {
                    message.text = "success"
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondVC = storyboard.instantiateViewController(identifier: "SecondViewController")

                    show(secondVC, sender: self)

                } else {
                    message.text = "Enter min 6 sym include 1 upper, 1 lowercase character and 1 num"
                }
            } else if pass.isEmpty {
                message.text = "error"
            } else {
                message.text?.removeAll()
            }
        } else if validateEmail(candidate: email) && validatePassword(candidate: pass) {
            message.text?.removeAll()
        } else {
            message.text = "error"
        }
    }
    
    func loginButtonEnabled() {
        if loginTextField.text?.isEmpty == false && passTextField.text?.isEmpty == false {
            message.text?.removeAll()
            loginButton.isEnabled = true
        } else {
            message.text?.removeAll()
        }
    }
    
    // https://emailregex.com/
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    func validatePassword(candidate: String) -> Bool {
        let passRegex = "^(?=.*?[0-9])(?=.*?[a-z])(?=.*?[A-Z]).{6,}$"
        // ^ - начало
        // (?=.*?[0-9]) - как минимум одну цифру
        // (?=.*?[a-z]) - одну букву в нижнем регистре
        // (?=.*?[A-Z]) - одну в верхнем
        // .{6,} - пароль не меньше 6 символов
        // $ - конец
        return NSPredicate(format: "SELF MATCHES %@", passRegex).evaluate(with: candidate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
