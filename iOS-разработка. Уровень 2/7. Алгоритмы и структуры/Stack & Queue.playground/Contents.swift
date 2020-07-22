import UIKit
// Skillbox
// Скиллбокс

// для стэка - мы добавляем элемент в конец и из конца их забираем
class Stack<T> {
    private var array: [T]
    
    init(elements: [T]) {
        array = elements
    }
    
    func push(element: T) {
        array.append(element)
    }
    
    func pop() -> T? {
        array.removeLast()
    }
}

// для очереди - добавляем элемент в конец, а забираем из начала списка
class Queue<T> {
    private var array: [T]
    
    init(elements: [T]) {
        array = elements
    }
    
    func push(element: T) {
        array.append(element)
    }
    
    func pop() -> T? {
        array.removeFirst()
    }
}
