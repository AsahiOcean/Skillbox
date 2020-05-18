import UIKit

class ViewController: UIViewController, StepProtocol {
// MARK: 1. Прочитайте главу про протоколы.
// MARK: 2. Прочитайте главу про расширения.
// MARK: 3. Прочитайте статью про Protocol oriented programming.
// MARK: 4. В чем отличие класса от протокола?
/*
Класс - это описание для какого-либо объекта, другими словами конструктор.
Протокол - свод "инструкций", по которым может быть составлен класс.
*/

//MARK: 5. Могут ли реализовывать несколько протоколов:
/*
a. классы (Class)
b. структуры (Struct)
c. перечисления (Enum)
d. кортежи (Tuples)
*/ // MARK: примеры ниже
 
// MARK: 6. Создайте протоколы для:
/* Напишите класс, который реализует эти два протокола */
// MARK: примеры ниже

// MARK: 7. Создайте расширение с функцией для:
/*
a. CGRect, которая возвращает CGPoint с центром этого CGRect’а
b. CGRect, которая возвращает площадь этого CGRect’а
c. UIView, которое анимированно её скрывает (делает alpha = 0)
d. протокола Comparable, на вход получает еще два параметра того же типа: первое ограничивает минимальное значение, второе – максимальное; возвращает текущее значение. ограниченное этими двумя параметрами. Пример использования:
     7.bound(minValue: 10, maxValue: 21) -> 10
     7.bound(minValue: 3, maxValue: 6) -> 6
     7.bound(minValue: 3, maxValue: 10) -> 7
e. Array, который содержит элементы типа Int: функцию для подсчета суммы всех элементов
*/

// MARK: 8. В чем основная идея Protocol oriented programming?
// в том, чтобы использовать протоколы вместо классов, т.к. наследование классов ограничено одним суперклассом, а протоколов может быть сколько угодно
    
    var classGame : Chess!
    private let comp = Chess(name: "comp")
    private let player = Chess(name: "player")
    
    func compstep(newpos: CGPoint) {
        self.comp.pos = newpos
    }
    
    func playerstep(newpos: CGPoint) {
        self.player.pos = newpos
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.classGame = Chess()
        self.classGame.delegate = self
        
        // 5. Могут ли реализовывать несколько протоколов:
        print(EnumClock.clock())
        EnumClock.Answer()
        print(EnumClock.clock())
        print("\n")
        
        // 6. Создайте протоколы для:
        
        comp.pos = CGPoint(x: 0, y: 1)
        player.pos = CGPoint(x: 3, y: 3)
        
        classGame.delegate?.compstep(newpos: CGPoint(x: 99, y: 99))
        classGame.delegate?.playerstep(newpos: CGPoint(x: 123, y: 123))

        print("\n")
        Player(name: "Player").draw() // MARK: UPDATE
        Bird(name: "Bird").fly() // MARK: UPDATE
        print("\n")
        
        // 7. Создайте расширение с функцией для:
        print(ItemCenter)
        print(ItemArea)
        print("\n")
        let Square = essence
        Square.backgroundColor = .systemRed
        Square.frame.size = CGSize(width: 100, height: 100)
        Square.frame = CGRect(
            x: self.view.frame.midX - Square.frame.center().x,
            y: self.view.frame.midY - Square.frame.center().y,
            width: Square.frame.width,
            height: Square.frame.height)
        Square.alpha0()
        self.view.addSubview(Square)
        
        print(number.qwerty(minValue: 10, maxValue: 21))
        print(number.qwerty(minValue: 3, maxValue: 6))
        print(number.qwerty(minValue: 3, maxValue: 10))
        print("\n")
        print(IntArray.sum())
        print("\n")
        
        // MARK: UPDATE
        print(Tuples)
    }
}

//MARK: -- 5. Могут ли реализовывать несколько протоколов:
//MARK: a. классы (Class)
protocol CLASSprotocolA {
    var name: String { get set }
}
protocol CLASSprotocolB {
    var age: Int {get set }
}
class CLASS: CLASSprotocolA, CLASSprotocolB {
    // реализация протоколов
    var name: String = "username"
    var age: Int = 25245
}
//MARK: b. структуры (Struct)
protocol STRUCTprotocolA {
    var text: String { get set }
}
protocol STRUCTprotocolB {
    var number: Int { get set }
}
struct STRUCT: STRUCTprotocolA, STRUCTprotocolB {
    var text: String
    var number: Int
}
//MARK: c. перечисления (Enum)
protocol EnumProtocolA {
    var Question: String { get }
}
protocol EnumProtocolB {
    mutating func Answer()
}
extension EnumProtocolB {
    func TellTime() -> String {
        "\(Date())"
    }
}
enum Enum: EnumProtocolA, EnumProtocolB {
// Перечисления не могут содержать stored properties (хранимые переменные либо константы), но можно сделать так
    case WhatTimeIsIt, CheckTime
    
    var Question: String { self.clock() }

    func clock() -> String {
        switch self {
        case .WhatTimeIsIt:
            return "Который сейчас час?"
        case .CheckTime:
            return "\(TellTime())"
        }
    }
    mutating func Answer() {
        self = Enum.CheckTime
    }
}
var EnumClock = Enum.WhatTimeIsIt

//MARK: d. кортежи (Tuples)
// для кортежей не нашел информации по реализации протоколов
// MARK: кажется нашел
protocol StructProtocolA {
    var Question: String { get }
}
protocol StructProtocolB {
    mutating func Answer()
}
struct TuplesStruct: StructProtocolA, StructProtocolB {

    var Question: String
    
    mutating func Answer() {
        print("PUK")
    }
    
    var name: String
    var age: Int
}
let Tuples = TuplesStruct(Question: "where am from?", name: "Jopa", age: 0)
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



//MARK: -- 6. Создайте протоколы для:
//MARK: a. игры в шахматы против компьютера: протокол-делегат с функцией, через которую шахматный движок будет сообщать о ходе компьютера (с какой на какую клеточку); протокол для шахматного движка, в который передается ход фигуры игрока (с какой на какую клеточку), Double свойство, возвращающая текущую оценку позиции (без возможности изменения этого свойства) и свойство делегата;

protocol StepProtocol {
    func compstep(newpos: CGPoint)
    func playerstep(newpos: CGPoint)
}

protocol PosProtocol {
    var pos: CGPoint { get set }
}

class Chess: PosProtocol {
    var delegate: StepProtocol?
    
    var name: String = ""
    
    required init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "noname")
    }
    
    var pos: CGPoint {
        get { return .init() }
        set { print("\(self.name) \(newValue)") }
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
//MARK: b. компьютерной игры: один протокол для всех, кто может летать (Flyable), второй – для тех, кого можно отрисовывать приложении (Drawable).
protocol Flyable {
    func fly()
    init(name: String)
    func draw()
}
protocol Drawable {
    var name: String { get set }
    func draw()
}
class Game: Drawable {
    var name: String = ""
    
    required init(name: String) {
        self.name = name
    }
    
    func draw() { // MARK: допустим, что все объекты отрисованы по-умолчанию
        print("\(self.name) отрисован")
    }
}
class Player: Game { }

class Bird: Game, Flyable {
    func fly() {
        print("\(self.name) летает")
    }
}
//MARK: -- 7. Создайте расширение с функцией для:
//MARK: a. CGRect, которая возвращает CGPoint с центром этого CGRect’а
extension CGRect {
    func center() -> CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
var Item = CGRect(x: 0, y: 0, width: 10, height: 10)
let ItemCenter = Item.center() // (5.0, 5.0)

//MARK: b. CGRect, которая возвращает площадь этого CGRect’а
extension CGRect {
    func area() -> CGFloat {
        width * height
    }
}
let ItemArea = Item.area() // 100.0

//MARK: c. UIView, которое анимированно её скрывает (делает alpha = 0)
extension UIView {
    func alpha0() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat,.autoreverse], animations: {
            self.alpha = 0
        })}
}
let essence = UIView()
//MARK: d. протокола Comparable, на вход получает еще два параметра того же типа: первое ограничивает минимальное значение, второе – максимальное; возвращает текущее значение. ограниченное этими двумя параметрами. Пример использования:

let number = 7
extension Comparable {
    func qwerty(minValue: Self, maxValue: Self) -> Self {
        if (self < minValue) {
            return minValue //MARK: 7.bound(minValue: 10, maxValue: 21) -> 10
        } else if (self > maxValue) {
            return maxValue //MARK: 7.bound(minValue: 3, maxValue: 6) -> 6
        }
        return self //MARK: 7.bound(minValue: 3, maxValue: 10) -> 7
    }
}
//MARK: e. Array, который содержит элементы типа Int: функцию для подсчета суммы всех элементов
extension Sequence where Element: AdditiveArithmetic {
// https://developer.apple.com/documentation/swift/additivearithmetic
    func sum() -> Element {
        return reduce(.zero, +)
    }
}
let IntArray = (0...10) // 55
