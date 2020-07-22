import UIKit
// Skillbox
// Скиллбокс

// LinkedList
class LLNode<T> {
    var key: T?
    var next: LLNode<T>?
    var previous: LLNode<T>?
    
    init(value: T?) {
        key = value
    }
    
    // convenience - чтобы можно было вызвать собственный конструктор
    convenience init(values: [T]) {
        self.init(value: values.first)
        var current = self
        for i in 1..<values.count {
            let next = LLNode(value: values[i])
            current.next = next
            current = next as! Self
            
        }
    }
}

let list = LLNode(values: [1,2,3,4,5])
list.key
list.next?.key
list.next?.next?.key
