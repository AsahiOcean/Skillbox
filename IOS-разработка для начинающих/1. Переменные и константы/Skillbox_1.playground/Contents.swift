import UIKit

// MARK: Необходимо выполнить несколько заданий с кодом:

// MARK: -- 1. Опишите словами, в чем разница между let и var
// let - это константа и она неизменна в процессе компиляции
// var - переменная, её значение может быть изменено в любой момент.

// MARK: -- 2. Возможен ли следующий код?
var name1 = "Nikita", name2 = "Anton", name3 = "Maria"
// Возможен, т.к. name1, name2 и name3 являтся переменными

// MARK: -- 3. Какой тип будет у следующих констант (ответьте не используя для проверки Xcode):
/*
let a = 7 // Int (целое число без плавающей точки и кавычек)
let b = 7.0 // Double (число с плавающей точкой)
let c = "7" // String (значение написано в кавычках)
let d = UInt8.max // UInt8 (беззнаковое целое число в 8-битном формате)
let e =  1_000_000 // Int (целое число без плавающей точки и кавычек)
*/

// MARK: -- 4. Что произойдет в результате выполнения следующего кода let number: Int = Int.max + 1
// Произойдет ошибка, т.к. будет превышено максимально допустимое значение Int

// MARK: -- 5. Приведите 3 примера (с кодом), в которых будут удобны tuples
// 1: let localhost = (ip: "127.0.0.1", hostname: "localhost", static: true)

// 2: let day = (hours: 24, minutes: 60, seconds: 60)

// 3: let skillbox_geo = (place: "Skillbox", latitude: 55.727739, longitude: 37.606936, static: true)

// MARK: -- 6. Представим, что у нас есть код:
let age = 25
let name = "Nikita"
// let greeting = "?"
// MARK: Что должно быть вместо знака «?», чтобы в результате получилось «Hello <Значение name>, your age is <значение age>»?

let greeting = "Hello \(name), your age is \(age)"
print(greeting)

// MARK: -- 7. Чему равны выражения (ответьте не используя для проверки Xcode):

let a = 21 / 8 // a = 2.625
let b = 21 % 8 // b = 5
let c = a == b // false ("a" не равен "b")
let d = a != b // true ("a" не равен "b")
let e = c && d // false (true на выходе будет, когда оба операнда также равны true)
let f = c || d // true (один из операндов имеет значение true)

// MARK: Ссылка на книгу: https://itunes.apple.com/ru/book/the-swift-programming-language-swift-4-1/id881256329?mt=11
// Skillbox
// Скиллбокс
