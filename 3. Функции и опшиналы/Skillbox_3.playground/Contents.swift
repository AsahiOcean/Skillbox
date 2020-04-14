import UIKit

// MARK: -- Необходимо выполнить несколько заданий с кодом.

// MARK: 1. Прочитайте главы Functions и Basics (начиная с Optionals) в книге «The Swift Programming Language»
// MARK: 2. Можно ли в функции вызвать другую функцию? Если да, приведите пример

func Temperature(_ array: Int...) -> (min: Int, max: Int) {
    func Min() -> Int {
        var minTemp = array[0]
        for v in array {
            if v < minTemp {minTemp = v}
        }
        return minTemp
    }
    func Max() -> Int {
        var maxTemp = array[0]
        for v in array {
            if v > maxTemp {maxTemp = v}
    }
        return maxTemp
    }
    return (Min(), Max())
}
Temperature(-15, -10, -4, -9, -12, -7, -3)

// MARK: -- 3. Напишите функцию, которая получает на вход массив строк, а возвращает одну строку, содержащую все элементы полученного массива через запятую

var cities = ["Sydney", "Auckland", "Los Angeles", "Capetown", "Tokyo", "Vancouver", "Madrid"]
var string = cities.joined(separator: ", ")

// MARK: -- 4. Напишите функцию, которая получает на вход два Int’а и меняет их значения, и при этом увеличивает их вдвое

func focus(q: inout Int, w: inout Int){
    let e = q
    q = (w * 2)
    w = (e * 2)
}
var q = 4
var w = 5

focus(q: &q, w: &w)

q
w

// MARK: -- 5. Напишите функцию, которая получает на вход два массива с типом Int и возвращает true, если сумма чисел в первом массиве больше суммы чисел во втором массиве; иначе возвращает false

func compareSums(_ array1: [Int], _ array2: [Int]) -> Bool {
    return array1.reduce(0, +) > array2.reduce(0, +)
}
var array1 = [2, 3, 5, 8]
var array2 = [13, 21, 34, 55]

compareSums(array1, array2)

// MARK: -- 6. Напишите функцию, которая получает на вход массив Int и возвращает этот же массив, но отсортированный по убыванию

func descending(_ array3: [Int]) -> [Int] {
    return array3.sorted(by: >)
}
var array3 = [454, 24, 3, 123, 780, 91, 52, 245]

descending(array3)

// MARK: -- 7. Напишите функцию, которая получает на вход массив Int и возвращает среднее значение всех элементов

func mean(_ array4: [Double]) -> Double {
    return array4.reduce(0, +) / Double(array4.count)
}
var array4: [Double] = [143, 865, 547, 789, 372, 486]

mean(array4)

// MARK: -- 8. Напишите функцию, которая пытается найти индекс строки в массиве: на вход получает массив и строку для поиска, возвращает опшионал индекс этой строки в массиве

func findIndex(_ valueToFind: String, in cities: [String]) -> Int? {
    for (index, value) in cities.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

findIndex("Capetown", in: cities) // 3

// MARK: -- 9.  Чему будет равен result?
// MARK: Ответ: "Hello, young man/woman 0"

var age = Int("25.") ?? 0 // опшинал Int имеет Double-значение - что несовместимо, а после ?? идет дефолтное значение, если первое указано неверно или отсутствует
var result1 = age < 18 ? "Hello, young man/woman" : "Hello grown man/woman"
result1 += " \(age)"

// MARK: -- 10. Чему будет равен result?

func inc(a: Int) -> Int{
    return a + 3
}

func dec(a: Int) -> Int{
    return a - 5
}

func compute(a: Int) -> Int{
    return inc(a: a) + dec(a: a)
}

let result = compute(a: 5) - compute(a: 3) // MARK: Ответ: 4

// MARK: -- Бонусные задания к урокам:

// MARK: Функции
// MARK: Можно ли в функции вернуть tuple? Можно ли внутри функции написать другую функцию?

// MARK: Можно и то и другое, см. задание 2.

// MARK: Опшиналы
// MARK: В каких случаях следует использовать восклицательный знак для опшиналов?

// MARK: Когда не обойтись без значения опшинала (т.е. опшинал не должен быть nil-ом)
// MARK: К примеру, чтобы сложить значения двух Int-ов, если первое будет обычным Int-ом, а другое опшиналом, то необходимо указать, что второе значение точно не nil, т.е. поставить после опшинала восклицательный знак
