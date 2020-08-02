// https://ru.wikipedia.org/wiki/Посетитель_(шаблон_проектирования)
// https://en.wikipedia.org/wiki/Visitor_pattern
/*
 Посетитель — это поведенческий паттерн, который позволяет добавить новую операцию для целой иерархии классов, не изменяя код этих классов. (Источник: https://refactoring.guru/ru/design-patterns/visitor/swift/example)

 Посетитель позволяет добавлять в программу новые методы, не изменяя классы объектов, над которыми эти методы могут выполняться.
*/
import Foundation

protocol Goods {
    var name: String { get set }
    var RFB: Bool { get set }
    var price: Int { get set }
}

class Unit: Goods {
    var name: String
    var RFB: Bool
    var price: Int
    
    init(name: String, RFB: Bool, price: Int) {
        self.name = name
        self.RFB = RFB
        self.price = price
    }
}

protocol Store {
    var units: [Goods] { get set }
    func addunit(unit: Goods)
    func observer(visitor: Visitor)
}

class Apple: Store {
    var units: [Goods] = []
    
    internal func addunit(unit: Goods) {
        self.units.append(unit)
    }
    
    /// метод принятия посетителей, который знает только о базовом интерфейсе посетителей
    internal func observer(visitor: Visitor) {
        for unit in self.units {
            // возвращаем результат методу посетителя
            visitor.checking(unit: unit as Any)
        }
    }
}

// интерфейс посетителя
protocol Visitor {
    var viewed: [Any] { get set }
    func checking(unit: Any)
}

// классы "посетителей", которые реализуют интерфейс, определенный в Visitor
class Manager: Visitor {
    var viewed: [Any] = []
    
    internal func checking(unit: Any) {
        if let goods = unit as? Goods {
            self.viewed.append(goods)
            if goods.RFB {
                print("\(goods.name) is RFB")
            } else {
                print("\(goods.name) is not RFB")
            }
        }
    }
}

class Buyer: Visitor {
    var viewed: [Any] = []
    
    internal func checking(unit: Any) {
        self.viewed.append(unit)
    }
    
    internal func compare() {
        for item in self.viewed.indices {
            let goods = self.viewed[item] as! Goods
            print("\(goods.name) – \(goods.price)$")
        }
    }
}

let store = Apple()

store.addunit(unit: Unit(name: "iPhone 1", RFB: true, price: 399))
store.addunit(unit: Unit(name: "iPhone 2", RFB: false, price: 599))
store.addunit(unit: Unit(name: "iPhone 3", RFB: false, price: 899))

let buyer = Buyer()
let manager = Manager()

store.observer(visitor: buyer)
buyer.compare()
print()
store.observer(visitor: manager)

// Skillbox
// Скиллбокс
