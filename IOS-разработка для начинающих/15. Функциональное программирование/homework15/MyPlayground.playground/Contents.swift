import UIKit
// Skillbox
// Скиллбокс
/*
1) Напишите своими словами, что такое pure function
2) Отсортируйте массив чисел по возрастанию используя функцию sorted
3) Переведите массив числе в массив строк с помощью функции map
4) Переведите массив строк с именами людей в одну строку, содержащую все эти имена, с помощью функции reduce
5) Напишите функцию, которая принимает в себя функцию c типом (Void) -> Void, которая будет вызвана с задержкой в 2 секунды
6) Напишите функцию, которая принимает в себя две функции и возвращает функцию, которая при вызове выполнит первые две функции
7) Напишите функцию, которая сортирует массив по переданному алгоритму: принимает в себя массив чисел и функцию, которая берет на вход два числа и возвращает Bool (должно ли первое число идти после второго) и возвращает массив, отсортированный по этому алгоритму
8) Напишите своими словами что такое infix, suffix, prefix операторы.
*/

// MARK: -- 1) Напишите своими словами, что такое pure function
print("- - - - - - - - Задание 1 - - - - - - - -")

print("pure function - «чистая функция», она не изменяет тип данных, которые были у нее на входе.")
print("Это делает код более лаконичным, с ней не нужно копипастить код, можно просто вызвать функцию.")

func Hello(name: String) -> String {
    return "Привет, " + name
}

Hello(name: "username")
Hello(name: "username2")
Hello(name: "username3")

// MARK: -- 2) Отсортируйте массив чисел по возрастанию используя функцию sorted
print("\n" + "- - - - - - - - Задание 2 - - - - - - - -")

func n() -> Int {arc4random().nonzeroBitCount} // маленький генератор
func RandomIntArray() -> [Int] {
    (1..<n()).map { _ in .random(in: 0...n()) }
}

let IntArray = RandomIntArray()

print("Raw массив: \(IntArray)")
print("Sorted массив: \(IntArray.sorted())")

// MARK: -- 3) Переведите массив числе в массив строк с помощью функции map
// Появилась ассоциация с прошлой работы в "корпорации BotFarm" и задумка как это можно реализовать
print("\n" + "- - - - - - - - Задание 3 - - - - - - - -")

func lowcards() -> [Int] { (0..<5).map { _ in .random(in: 2...10) } }
func suit() -> String { ["􀊼","􀊽","􀊾","􀊿"].randomElement()! }

var LowStartingHand = lowcards().map { "\($0)\(suit())" }

print("Стартовая рука: \(LowStartingHand)" + "\n")

// MARK: -- 4) Переведите массив строк с именами людей в одну строку, содержащую все эти имена, с помощью функции reduce
print("- - - - - - - - Задание 4 - - - - - - - -")

let DefaultName = "Username"

func UsersGenerator() -> [String] {
    let filter = Array(NSOrderedSet(array: RandomIntArray().sorted())) as! [Int] // убирает повторяющиеся элементы RandomIntArray
    return filter.filter { $0 > 0 }.map { DefaultName + " \($0)" } // фильтруем от 0 и к DefaultName добавляем элементы массива
}

let Users = UsersGenerator().reduce("") { "\($0)\($1), "}
print(Users.dropLast(2)) // заодно отрезаем последние ", "

// MARK: -- 5) Напишите функцию, которая принимает в себя функцию c типом (Void) -> Void, которая будет вызвана с задержкой в 2 секунды

//func func0(_: Void) -> Void {
//    print("Запустилась первая функция")
//}
//
//func Func2() -> Void  {
//    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
//        print("Запустилась вторая функция")
//    }
//}
//func0(Func2())

// MARK: К примеру это можно использовать еще и так:

var balance = 1

func Game() {
    let gamer = UsersGenerator().randomElement()
    switch balance >= 1 {
    case true:
        balance - 1
        print("\n" + "- - - - - - - - Задание 5 - - - - - - - -")
        print(Hello(name: "\(gamer!)"))
        GiveoutCards(Hand())
    default:
        print("\n  \(gamer!), пополните свой баланс!")
    }
}

func GiveoutCards(_: Void) -> Void {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
        print("Идёт раздача карт...")
    }
}
func Hand() -> Void {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
        print((Array(NSOrderedSet(array: LowStartingHand)) as! [String]).reduce("") { "\($0)\($1) "})
        // Иногда выдает 4 карты, тогда придется играть с тем, что есть - это жизнь))
    }
}

DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) { // для выдачи в консоль после принтов из 6 и 7 задания
    Game()
}

// MARK: -- 6) Напишите функцию, которая принимает в себя две функции и возвращает функцию, которая при вызове выполнит первые две функции ШТО?

print("\n" + "- - - - - - - - Задание 6 - - - - - - - -")

// MARK: смею преположить, что фунции должно быть три, но правда не догоняю как это завернуть, чтобы компуктер не взорвался от зацикливания
//func func0(_: @escaping () -> Void, _: @escaping () -> Void) -> Void {
//    return func3(_: func1(), _: func2())
//}
//func func1() {
//    print("func1")
//}
//func func2() {
//    print("func2")
//}
//func func3 (_: (Void), _: (Void)) {
//    print("func3")
//}
//
//func0(_: func1, _: func2)

// MARK: Попытка номер 2: вроде норм
func test1(_: @escaping () -> Void, _: @escaping () -> Void) -> (Void) {
    print("test1: ок")
    return test3()
}
func test2() {
    print("test2: ок")
}
func test3() {
    test1
    test2()
    print("test3: ок")
}

test1(test2,test3)

// MARK: -- 7) Напишите функцию, которая сортирует массив по переданному алгоритму: принимает в себя массив чисел и функцию, которая берет на вход два числа и возвращает Bool (должно ли первое число идти после второго) и возвращает массив, отсортированный по этому алгоритму
// MARK: Одно задание веселее другого

print("\n" + "- - - - - - - - Задание 7 - - - - - - - -")

func Descending(v1: Int, v2: Int) -> Bool {
    v1 > v2 ? true : false
}

func ArrayReception(RawArray: [Int], Descending: (Bool)) -> [Int] {
    var array = RawArray
    Descending ? array.sort {$0 > $1} : array.sort {$0 < $1}
    return array
}
print("Сортировка массива по возрастанию")
print(ArrayReception(RawArray: IntArray, Descending: false))

print("\n" + "Сортировка массива по убыванию")
print(ArrayReception(RawArray: IntArray, Descending: true))


// MARK: -- 8) Напишите своими словами что такое infix, suffix, prefix операторы.
print("\n" + "- - - - - - - - Задание 8 - - - - - - - -")

// MARK: infix - оператор который, работает с между двумя аргументами (необязательно с числами)

infix operator ** : AdditionPrecedence // новый оператор возведения в степень
func ** (base: Double, exponent: Double) -> Double { // будет работать только для Double
//  base - основание степени, exponent - показатель степени
/* тут мог бы быть описан принцип работы алгоритма нового оператора */
// p.s. или можно просто использовать "pow(base, exponent)"
    return Array(repeating: base, count: Int(exponent)).reduce(1, *)
}

print("\n" + "- - - - - - - - - infix - - - - - - - - -")
let base = 6
let exponent = 3
print("Число \(base) в степени \(exponent) равно \(6 ** 3)")
print("- - - - - - - - - - - - - - - - - - - - -")

// MARK: -- suffix & prefix
print("\n" + "- - - - - - - - suffix & prefix - - - - - - - -")

let array = RandomIntArray().sorted() // еще можно какой-нибудь фильтр прикрутить типа .filter { $0 > 10 }
let x = 5

print("suffix(\(x)) оставляет \(array.suffix(x).count) последних элемент(а/ов)")
print("Было: \(array)")
print("Стало: \(array.suffix(x))")

print("\n" + "prefix(\(x)) оставляет \(array.prefix(x).count) первых элемент(а/ов)")
print("Было: \(array)")
print("Стало: \(array.prefix(x))")

print("\n" + "- - - - - - - - dropFirst & dropLast - - - - - - - -")

print("dropFirst(\(x)) отрезает \(array.count - array.dropFirst(x).count) первых элемент(а/ов)")
print("Было: \(array)")
print("Стало: \(array.dropFirst(x))" + "\n")

print("dropLast(\(x)) отрезает \(array.count - array.dropLast(x).count) последних элемент(а/ов)")
print("Было: \(array)")
print("Стало: \(array.dropLast(x))")

// MARK: а для строк так:

print("\n" + "- - - - - - - - hasPrefix & hasSuffix - - - - - - - -")

let text = "Hello, world"
let nachalo = "Hello"
let konec = "world"

if text.hasPrefix(nachalo) {
    print("Все ок! «\(nachalo)» есть в начале строки!")
} else {
    print("«\(nachalo)» нет в начале строки!")
}

if text.hasSuffix(konec) {
    print("Все ок! В конце строки есть «\(konec)»")
} else {
    print("«\(konec)» в конце строки нет!")
}
