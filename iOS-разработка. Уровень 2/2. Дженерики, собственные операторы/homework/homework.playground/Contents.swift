import UIKit
import PlaygroundSupport

// 1. Прочитайте главу про дженерики и ассоциированные типы.
// 2. Прочитайте главу про операторы.
// 3. Посмотрите код полной реализации библиотеки анимаций.
// 4. Для чего нужны дженерики?
/*
Чтобы создавать часто используемые функции, либо данные, которые работают с любым определенным типом данных <T>
*/

// 5. Чем ассоциированные типы отличаются от дженериков?
// Ассоциированные типы - аналоги дженериков, только для протоколов

// MARK: -- 6. Создайте функцию, которая:
//MARK: 6a
// a. получает на вход два Equatable объекта и в зависимости от того, равны ли они друг другу, выводит разные сообщения в лог
func equal<T: Equatable>(f: T, s: T) {
    if f == s { print("\(f) == \(s)")
    } else { print("\(f) != \(s)")
}}
equal(f: "name1", s: "name2")
print("name1" == "name2")

//MARK: 6b
//b. получает на вход два сравниваемых (Comparable) друг с другом значения, сравнивает их и выводит в лог наибольшее

func highvalue(a: Double, b: Double) -> Double  {
if a > b { return a } else { return b }}
highvalue(a: 111, b: 222)
print(max(111, 222))

//MARK: 6c
//c. получает на вход два сравниваемых (Comparable) друг с другом значения, сравнивает их и перезаписывает первый входной параметр меньшим из двух значений, а второй параметр – большим

func substitution<T: Comparable>(f: T, s: T) {
let t1 = min(f, s); let t2 = max(f, s); print(t1,t2)
}; substitution(f: 999, s: 111)

func swapTwo<T>(_ a: inout T, _ b: inout T) {
    let temp = a; a = b; b = temp
}
//MARK: 6d
//d. Создайте функцию, которая: получает на вход две функции, которые имеют дженерик входной параметр Т и ничего не возвращают; сама функция должна вернуть новую функцию, которая на вход получает параметр с типом Т и при своем вызове вызывает две функции и передает в них полученное значение (по факту объединяет вместе две функции)

func complexFunction<T>(firstSelector: @escaping(_ par1: T) -> (), secondSelector: @escaping(_ par2: T) -> ()) -> (T) -> () {
    let returnFunction: (T) -> () = { tValue in
        firstSelector(tValue)
        secondSelector(tValue)
    }
    return returnFunction
}

complexFunction(firstSelector: { (T) in
    return T
}, secondSelector: { (T) in
    return T
})

//MARK: -- 7. Создайте расширение для:
    // MARK: 7a
    //a. Array, у которого элементы имеют тип Comparable и добавьте генерируемое свойство, которое возвращает максимальный элемент
extension Array where Element: Comparable {
    func maximum() -> Element? {
        guard let first = self.first else {
            return nil
        }
        return reduce(first, Swift.max)
    }
}
var IntArray = [1,4,2,3,5,67,8,0,999,999]
IntArray.max() //MARK: оно ведь уже есть
IntArray.maximum()

    // MARK: 7b
    //b. Array, у которого элементы имеют тип Equatable и добавьте функцию, которая удаляет из массива идентичные элементы
    //MARK: Все? или один?

// MARK: 7b - все. Если одинаковый элементов больше одного, остается один.

extension Array where Element: Equatable {
    func Duplicate() -> [Element] {
        var result = [Element]()
        for el in self {
            if result.contains(el) == false {
                result.append(el)
            }
        }
        return result
    }
    func HardRemoveDuplicate() -> [Element] {
        var test1 = [Element]()
        var test2 = [Element]()
        for el in self {
            if test1.contains(el) == false {
                test1.append(el)
            } else {
                test2.append(el)
            }
        }
        return test1.filter { return !test2.contains($0) }
    }
//    func WhatIsDeleted() -> [Element] {
//        var temp = [Element]()
//        var result = [Element]()
//        for value in self {
//            if temp.contains(value) == false {
//                temp.append(value)
//            } else {
//                result.append(value)
//            }
//        }
//        return result
//    }
//    static func -(lhs: Array, rhs: Array) -> Array {
//        return lhs.filter { return !rhs.contains($0) }
//    }
}

IntArray
IntArray.Duplicate() // MARK: удалит дубликат 999
IntArray.HardRemoveDuplicate() // MARK: так 999 совсем нет

// IntArray - IntArray.WhatIsDeleted() // так дубликатов вообще нет
//MARK: -- 8. Создайте специальный оператор для:
    // MARK: 8a
    //a. Создайте специальный оператор для возведения Int числа в степень: оператор ^^, работает 2^3 возвращает 8
    infix operator ^^
    func ^^ (base: Int, exponent: Int) -> Int {
        Array(repeating: base, count: Int(exponent)).reduce(1, *)
    }
    2^^3
    pow(2, 3) // MARK: в домашках идут одни и те же задания, забавно
    // MARK: 8b
    //b. Создайте специальный оператор для копирования во второе Int число удвоенное значение первого 4 ~> a после этого a = 8
    postfix operator ~>
    postfix func ~> (a: Int) -> [Int] {
        [a,a*2]
    }
    4~>
    // MARK: 8c
    //c. Создайте специальный оператор для присваивания в экземпляр tableView делегата: myController <* tableView поле этого myController становится делегатом для tableView

    infix operator <*
    func <*(myController: UIViewController, tableView: UITableView) {
        var mc: Void = myController.viewDidLoad()
        mc = {
            tableView.delegate
            tableView.dataSource
        }()
        mc.self
    }

    let vc1 = UIViewController()
    let tv1 = UITableView()

    vc1 <* tv1
    
    //MARK: 8d
    //d. Создайте специальный оператор для суммирует описание двух объектов с типом CustomStringConvertable и возвращает их описание: 7 + “ string” вернет “7 string”
struct Point {
    let num: Int
    let srt: String
}
extension Point: CustomStringConvertible {
    var description: String {
        return "\(num)" + " \(srt)"
    }
}
let point = Point(num: 7, srt: "string")

//MARK: -- 9. Напишите для библиотеки анимаций новый аниматор:
    //MARK: 9a
    //a. изменяющий фоновый цвет для UIView
let view = UIView()
view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
protocol BCprotocol {
    associatedtype Target
    func backAnimator(t: Target)
}
class ViewClass: BCprotocol, centerProtocol, scaleProtocol {
    func scaleAnimator(t: UIView) {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat,.autoreverse], animations: {
            view.transform = CGAffineTransform(scaleX: 2, y: 2)
        })
    }
    
    func CenterChange(t: UIView) {
        view.center = CGPoint(x: 100, y: 100)
    }
    
    func backAnimator(t: UIView) {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat,.autoreverse], animations: {
            t.backgroundColor = .systemRed; t.backgroundColor = .systemBlue
        })
    }
}
ViewClass().backAnimator(t: view)
ViewClass().CenterChange(t: view)
ViewClass().scaleAnimator(t: view)
PlaygroundPage.current.liveView = view
    //MARK: 9b
    //b. изменяющий center UIView
protocol centerProtocol {
    associatedtype Target
    func CenterChange(t: Target)
}
    //MARK: 9c
    //c. делающий scale трансформацию для UIView
protocol scaleProtocol {
    associatedtype Target
    func scaleAnimator(t: Target)
}
