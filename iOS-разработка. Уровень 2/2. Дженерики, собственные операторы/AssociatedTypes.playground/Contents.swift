import UIKit
// Ассоциированные типы - аналоги дженериков, только для протоколов

protocol Container {
    associatedtype Element // : Equatable
    
    var count: Int { get }
    
    subscript(i: Int) -> Element { get }
    
    mutating func append(_ item: Element)
}

extension Container where Element: Equatable {
    func findIndexOf(item: Element) -> Int? {
        for i in 0..<count {
            if self[i] == item {
                return i
            }
        }
        return nil
    }
}
