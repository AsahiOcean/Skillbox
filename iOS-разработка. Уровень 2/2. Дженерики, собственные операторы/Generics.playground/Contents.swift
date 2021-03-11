import UIKit

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

var int1 = 7
var int2 = 9
swapTwoInts(&int1, &int2)
int1
int2

// - - - - - - - - - - - - - - - - - - - - - - - - - -

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temp = a
    a = b
    b = temp
}
var str1 = "text1"
var str2 = "text2"
swapTwoStrings(&str1, &str2)
str1
str2

// - - - - - - - - - - - - - - - - - - - - - - - - - -
// Дженерики
func swapTwo<T> (_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}
var int3 = 3
var int4 = 4
swapTwo(&int3, &int4)
int3
int4

var str3 = "text3"
var str4 = "text4"
swapTwo(&str3,&str4)
str3
str4
// - - - - - - - - - - - - - - - - - - - - - - - - - -
// MARK: Стек:
// Стек из любых элементов
struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stack1 = Stack(items: [1,2,3])
stack1.pop()

// добавление Equatable указывает, что поиск будет происходить только по элементам, которые можно сравнить
func findIndex<T: Equatable>(valueToFind: T, inArray: [T]) -> Int? {
    for (index,value) in inArray.enumerated() {
        if value == valueToFind { return index }
    }
    return nil
}
extension Array where Element: Equatable {
    func findIndex(valueToFind: Element) -> Int? {
        for (index,value) in enumerated() {
            if value == valueToFind { return index }
        }
        return nil
    }
}

var intArray = [1,2,3,4,5,6]
findIndex(valueToFind: 2, inArray: intArray)


intArray.findIndex(valueToFind: 3)
