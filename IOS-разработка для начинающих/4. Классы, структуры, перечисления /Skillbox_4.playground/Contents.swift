import UIKit
// Skillbox
// Скиллбокс

// MARK: -- 1. Прочитайте главы Enumerations и Classes and Structures в книге «The Swift Programming Language».
// MARK: -- 2. Если бы в вашей программе была работа с игральными картами, как бы вы организовали их хранение? Приведите пример.

struct PlayingCards {
    enum Suit: Character {
        case spades = "♠️"
        case hearts = "♥️"
        case diamonds = "♦️"
        case clubs = "♣️"
    }
    enum Rank: Int {
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        case eight = 8
        case nine = 9
        case ten = 10
        case jack = 11
        case queen = 12
        case king = 13
        case ace = 14
    }
}

// MARK: -- 3. Каких типов могут быть raw значения кейсов enum’а?
// MARK: raw значения кейсов enum’а могут быть типом Int, String, Character или Float

// MARK: -- 4. Напишите класс и структуру для хранения информации (положение, размер) о круге, прямоугольнике.

class CircleClass {
    var Position: (X: Double, Y: Double)
    var Radius: Double
    var Perimeter = Double()
    var Area = Double()
        init?(X: Double, Y: Double, Radius: Double) {
            self.Position.X = X
            self.Position.Y = Y
            self.Radius = Radius
                if Radius == 0 { print("Это точка, а не круг"); return nil }
                if Radius < 0 { print("Радиус круга не бывает отрицательным"); return nil }
            self.Perimeter = 2 * Double.pi * Radius
            self.Area = Double.pi * (Radius * Radius)
        }
}

struct CircleStruct {
    var Position: (X: Double, Y: Double)
    var Radius: Double
    var Perimeter = Double()
    var Area = Double()
        init?(X: Double, Y: Double, Radius: Double) {
            self.Position.X = X
            self.Position.Y = Y
            self.Radius = Radius
                if Radius == 0 { print("Это точка, а не круг"); return nil }
                if Radius < 0 { print("Радиус круга не бывает отрицательным"); return nil }
            self.Perimeter = 2 * Double.pi * Radius
            self.Area = Double.pi * (Radius * Radius)
        }
}

var Circle1 = CircleClass(X: 123, Y: 321, Radius: 23)
var Circle2 = CircleStruct(X: 234, Y: 432, Radius: 42)

class RectangleClass {
    var Position: (X: Double, Y: Double)
    var Height: Double
    var Width: Double
    var Area = Double()
    var Perimeter = Double()
        init?(X: Double, Y: Double, Height: Double, Width: Double) {
            self.Position.X = X
            self.Position.Y = Y
            self.Height = Height
            self.Width = Width
                if Height <= 0 || Width <= 0 { return nil }
            self.Perimeter = (Height + Width) * 2
            self.Area = Height * Width
        }
}

struct RectangleStruct {
    var Position: (X: Double, Y: Double)
    var Height: Double
    var Width: Double
    var Area = Double()
    var Perimeter = Double()
        init?(X: Double, Y: Double, Height: Double, Width: Double) {
            self.Position.X = X
            self.Position.Y = Y
            self.Height = Height
            self.Width = Width
                if Height <= 0 || Width <= 0 { return nil }
            self.Perimeter = (Height + Width) * 2
            self.Area = Height * Width
        }
}

var Rectangle1 = RectangleClass(X: 99, Y: 123, Height: 30, Width: 81)
var Rectangle2 = RectangleStruct(X: 111, Y: 222, Height: 45.2, Width: 69.3)

// MARK: -- 5. Для следующего кода, выполнение каких строчек закончится ошибкой и почему:

class ClassUser1{
    let name: String
    init(name: String) {
        self.name = name
    }
}

class ClassUser2{
    var name: String
    init(name: String) {
        self.name = name
    }
}

struct StructUser1{
    let name: String
    init(name: String) {
        self.name = name
    }
}

struct StructUser2{
    var name: String
    init(name: String) {
        self.name = name
    }
}
/*
// MARK: 1. name в class ClassUser1 является константой, ее нельзя изменить
let user1 = ClassUser1(name: "Nikita")
user1.name = "Anton"

//2.
let user2 = ClassUser2(name: "Nikita")
user2.name = "Anton"

// MARK: 3. name в struct StructUser1 является константой, ее нельзя изменить
let user3 = StructUser1(name: "Nikita")
user3.name = "Anton"

// MARK: 4. name в struct StructUser2 является константой, ее нельзя изменить
let user4 = StructUser2(name: "Nikita")
user4.name = "Anton"

// MARK: 5. name в class ClassUser1 является константой, ее нельзя изменить
var user5 = ClassUser1(name: "Nikita")
user5.name = "Anton"

//6.
var user6 = ClassUser2(name: "Nikita")
user6.name = "Anton"

// MARK: 7. name в struct StructUser1 является константой, ее нельзя изменить
var user7 = StructUser1(name: "Nikita")
user7.name = "Anton"

//8.
var user8 = StructUser2(name: "Nikita")
user8.name = "Anton"
*/

// MARK: -- 6. Напишите пример класса автомобиля (какие поля ему нужны – на ваше усмотрение) с конструктором, в котором часть полей будет иметь значение по умолчанию.

class SaleNewCar {
    let Owners: Int = 0
    let Mileage: Int = 0
    var Mark: String
    var Model: String
    var Color: String
    var Price: Int
        init(Mark: String, Model: String, Color: String, Price: Int){
            self.Mark = Mark
            self.Model = Model
            self.Color = Color
            self.Price = Price
        }
}

var Car1 = SaleNewCar(Mark: "BMW", Model: "I8", Color: "White", Price: 12345678)

// MARK: -- 7. Напишите класс для калькулятора с функциями для сложения, вычитания, умножения и деления цифр, которые в нем хранятся как свойства.

class Calc {
    var first: Double
    var second: Double
        init(first: Double, second: Double){
            self.first = first
            self.second = second
        }
    func addition() -> Double {
        return first + second
    }
    func subtraction() -> Double {
        return first - second
    }
    func multiplication() -> Double {
        return first * second
    }
    func divison() -> Double {
        return first / second
    }
}

var calc = Calc(first: 111, second: 222)
calc.addition()
calc.subtraction()
calc.multiplication()
calc.divison()

// MARK: -- 8. В каких случаях следует использовать ключевое слово static?
// MARK: Когда необходимо существование только ОДНОГО определённого объекта, к которому можно обратиться из любого места программы.

// MARK: -- 9. Могут ли иметь наследников:
// MARK: 1. Классы - могут

class Class {
    let a: Int = 1
    let b: Int = 2
}
class SubClass: Class {
    let c: Int = 3
}

var sc = SubClass()
sc.a
sc.b
sc.c

// MARK: 2. Структуры - не могут
// MARK: 3. Enum’ы - не могут

// MARK: -- 10. Представим, что вы создаете rpg игру. Напишите структуру для хранения координаты игрока, enum для направлений (восток, сервер, запад, юг) и функцию, которая берет к себе на вход позицию и направление и возвращает новую координату (после того как игрок походил на одну клетку в соответствующую сторону). Вызовите эту функцию несколько раз, «походив» своим игроком

enum compass {
    case north, south, west, east
}

struct geo {
    var x = 0
    var y = 0
        init(x: Int, y: Int) {
            self.x = x
            self.y = y
        }
}

func idem (otkuda: geo, kuda: compass) -> (geo) {
    var x = otkuda.x
    var y = otkuda.y
    switch kuda {
    case .north: y = y + 1
    case .south: y = y - 1
    case .west: x = x - 1
    case .east: x = x + 1
    }
    return (geo(x: x, y: y))
}

var spot = geo(x: 0, y: 0)
spot = idem(otkuda: spot, kuda: .north); print("\(spot)")
spot = idem(otkuda: spot, kuda: .east); print("\(spot)")
spot = idem(otkuda: spot, kuda: .south); print("\(spot)")
spot = idem(otkuda: spot, kuda: .east); print("\(spot)")
spot = idem(otkuda: spot, kuda: .south); print("\(spot)")

// MARK: -- Бонусные задания к урокам:

// MARK: Енамы
// MARK: Можно ли в enum’е хранить дополнительные данные?
// Можно, например так:

enum CountryCode: String {
    case ru = "Russian Federation"
    case us = "United States"
    case au = "Australia"
    case ca = "Canada"
}

let rus = CountryCode.ru

rus.rawValue

// MARK: -- Классы
// MARK: В каких случаях удобнее структурировать данные и функции в класс?
// В случаях когда на класс будет ссылаться много объектов.

// MARK:--  Структуры
// MARK: В каких случаях лучше использовать класс, а в каких – структуру?

// Классы стоит использовать, когда предстоит работать с наследованием.
// Структуру используют когда нужно целиком скопировать её свойства, а не ссылаться на них.
// В структурах не обязательна инициализация, это экономит время.
 
// Стоит заметить, что константым объектам со свойствами структуры нельзя менять значение, в то время как у классов можно.

class UserClass{
    var name: String
    var age: Int
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
}
struct UserStruct{
    var name: String
    var age: Int
}

let tom: UserClass = UserClass(name: "Tom", age: 24)
let bob: UserStruct = UserStruct(name:"Bob", age: 24)
tom.age = 25        // MARK: работает
//bob.age = 25        // MARK: не работает
