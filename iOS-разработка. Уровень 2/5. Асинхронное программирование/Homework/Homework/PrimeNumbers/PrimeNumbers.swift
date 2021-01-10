import UIKit
import RxSwift
import RxCocoa
// Skillbox
// Скиллбокс
/*
 одно текстовое поле с вводом числа и кнопка “Рассчитать”.
 После нажатия на кнопку приложение должно в фоновом режиме найти все простые числа (которые делятся без остатка только на 1 и себя) от единицы до введенного числа.
 Все найденные числа нужно вывести в консоль вместе с длительностью расчета этих чисел (сколько времени ушло на поиск этих чисел).
 */
extension String {
    var isNumeric: Bool {
        return NumberFormatter().number(from: self) != nil
    }
}
class PrimeNumbers: UIViewController {
    @IBOutlet weak var Input: UITextField!
    @IBOutlet weak var Output: UITextView!
    
    let disposeBag = DisposeBag()
    
    //MARK: viewWillAppear == Main queue
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Input.rx.text.orEmpty.filter{(Int($0) ?? 0 > 0)}
            .subscribe(onNext: { text in
                self.Output.text = ""
                DispatchQueue.global(qos: .background).async {
                    print("~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~")
                    let nums = 1...Int(text)!
                    let start = CFAbsoluteTimeGetCurrent()
                    for num in nums {
                        var prime = true
                        if num == 1 {
                            prime = false
                        }
                        var i = 2
                        while (i < num) {
                            if num % i == 0 {
                                prime = false
                            }
                            i += 1
                        }
                        if prime == false {
                            let end = CFAbsoluteTimeGetCurrent()
                            print("\(num) не простое число. \(Float(end-start)*1000) мс")
                        } else {
                            let end = CFAbsoluteTimeGetCurrent()
                            print(">> \(num)  простое число. \(Float(end-start)*1000) мс")
                            //            var primeNum = [String()]
                            //            primeNum.append("\(num) простое число.")
                            //            print(primeNum.dropFirst())
                        }
                    }}
                self.Output.text = "Result in console 😉"
            }).disposed(by: disposeBag)
    }
}
