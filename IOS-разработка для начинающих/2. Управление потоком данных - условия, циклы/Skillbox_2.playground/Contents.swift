import UIKit

// MARK: -- 1. Прочитайте главы Collection Types и Control Flow в книге «The Swift Programming Language»

// MARK: -- 2.  Напишите все возможные варианты кода, в которых по-разному создается Int массив
var a = [Int]()
var b: [Int] = [1, 2, 3]
var c = [4, 5, 6]
var d = [[7,8,9], [10,11,12]]
var e = Array (13...15)
var f = b + c

// MARK: -- 3. Напишите код, который:
// MARK: 1. создаст массив из трех Int элементов
var g = 1
var h = 2
var i = 3
var result: [Int] = [g, h, i]

// MARK: 2. добавит в этот массив еще один элемент
result.append(4)

// MARK: 3. удалит первый элемент
result.remove(at: 0)

// MARK: 4. с помощью цикла найдет минимальное и максимальное число
var max = result[0]
var min = result[0]
for i in 0..<result.count {
    let i = result[i]
    if i > max {
        max = i
    }
    if i < min {
        min = i
    }
}
min // минимальное число
max // максимальное число

// MARK: 5. выведет в консоль разницу между максимальным и минимальным числом
print("\(max - min)")

// MARK: --  4. Напишите все возможные варианты кода, в которых по-разному добавляются новые элементы в массив
result = [1] + result
result.append(5)
result.append(contentsOf: [6, 7])
result.insert(8, at: 6)
result.insert(9, at: result.endIndex)
result += [10, 11]

var numbers = [12, 13]
result.append(contentsOf: numbers)

var numbers2 = [14, 15]
result = result + numbers2

// MARK: -- 5. Что получится в результате выполнения следующей программы:

var array = [7, 5, 2] // Создание массива
array[1] = 9 // Замена значения с индексом "1"
array[2] = array[1] + array[2] // Замена значения с индексом "2", суммой значений с индексами "1" и "2"
print(array[2]) // Вывод в консоль значения с индексом "2" из массива "array"

// MARK: Результат: 11

// MARK: -- 6. Напишите код, который:

// MARK: 1. Создаст массив с именами людей (строки)
var name: [String] = ["Tommy", "Alice", "Mark", "Eva"]

// MARK: 2. Создаст переменную greeting (пустую строку)
var greeting: [String] = []

// MARK: 3. В цикле для каждого четного (по порядку) имени добавит в строку greeting "Go left, \(name)"; для каждого нечетного – "Go right, \(name)"
for i in 0..<name.count {
    if i % 2 == 1 {
        greeting.append("Go left, \(name[i])")
    }
    if i % 2 == 0 {
        greeting.append("Go right, \(name[i])")
    }
}
print(greeting)

// MARK: --  7. Опишите словами, в чем различие между массивом и сетом
// MARK: В массивах элементы имеют индекс, в сетах такого нет - их структура хаотична; массивы можно сравнить с органайзером, а сеты с мешком. В сетах не может быть дублирующихся элементов, такова их структура, в отличии от массивов.

// MARK: --  8. Для следующего кода, что будет результатом выполнения подпунктов:
let myEmoji: Set = ["😂", "🎊", "🕺", "🚀"]
let wifeEmoji: Set = ["🎸", "😂", "🎊", "🦋"]
myEmoji.intersection(wifeEmoji) // возвращает одинаковые для обоих сетов элементы // {"🎊", "😂"}
myEmoji.symmetricDifference(wifeEmoji) // возвращает не одинаковые для обоих сетов элементы // {"🎸", "🕺", "🦋", "🚀"}
myEmoji.union(wifeEmoji) // объединяет оба сета // {"🦋", "🎸", "🎊", "🚀", "😂", "🕺"}
myEmoji.subtracting(wifeEmoji) // возвращает элементы первого сета, которых нет во втором // {"🕺", "🚀"}

// MARK: -- 9. Напишите по примеру для реального приложения, в которых вы бы использовали Set, Array и Dictionary
let salt: Set = ["Na", "Cl"]
let alphabet: Array<String> = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
var reside: [String: Int] = ["Alice": 6, "Tommy": 4, "Eva": 2, "Mark": 5, "Lisa": 3]

// MARK: -- 10. Для следующего кода допишите цикл, который выведет в консоль результат возведения числа number в степень power:

let number = 5
let power = 3
var answer = 1
for _ in 1...power {
    answer *= number
}

print("\(number) в степени \(power) равно \(answer)")

// MARK: -- 11. Представьте, что у нас есть константа, в которой мы храним настроение пользователя (число от 0 до 10):
let mood = 7

// MARK: 1. Напишите код, который в зависимости от значения этой константы (промежутки [0, 3], [4, 7], [8,10]) выводит в консоль разные сообщения пользователю с помощью if

if mood <= 0 && mood <= 3 {
    print("BAD!")
}

if mood >= 4 && mood <= 7 {
    print("Normal")
}

if mood >= 8 && mood >= 10 {
    print("Good Mood!")
}

// MARK: 2. аналогично, но вместо if используйте switch

switch mood {
case 0...3 :
    print("BAD!")
case 4...7 :
    print("Normal")
case 9...10 :
    print("Good Mood!")
default :
    print("Are you fine? Call your friends!")
}

// MARK: -- Бонусные задания к урокам:


// MARK: Коллекции
// Что выведется в консоль?

// var array = ["🏆", "😎", "🎰"]
// array[1] = "💃" // Замена первого элемента в массиве
// array[2] = array[1] + array[2] // "💃🎰" (Замена второго элемента суммой 1 и 2 элементов)
// print(array)

// MARK: В консоли: "["🏆", "💃", "💃🎰"]"

// MARK: Условия
// Что выведется в консоль?

// var array = ["🏆", "😎", "🎰"]
// if array.count == 3 && array[1] == "😎"{ print("Good emoji") } // Кол-во элементов array равно 3 и первый элемент (ПО ИНДЕКСУ) = "😎", то вывести "Good emoji"
// else { print("Bad emoji pack") }
// В консоли: Good emoji

// MARK: Циклы
// Что выведется в консоль?

// var sum = 0
// var array = [1, 2, 5, 9, 10, 12, 17]
// for v in array{
//      if v % 2 == 0 { sum += v } // Перебрать значения в array, если остаток от деления равен = 0, то переменной sum присвоить со сложением это значение (2+10+12=24)
// }
// print(sum)

// MARK: В консоли: 24

// MARK: -- Оператор switch
// MARK: В каких случаях удобнее использовать switch, а в каких if?

//  switch удобен когда выражение нужно проверить сразу на несколько условий (код становится компактнее и читабельнее), в то время как if всегда проверяет только на одно условие, а если if-else писать лесенкой, то код выйдет громоздким и где-то можно запутаться с условиями
