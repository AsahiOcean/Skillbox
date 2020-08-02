// https://ru.wikipedia.org/wiki/Фабричный_метод_(шаблон_проектирования)
// https://en.wikipedia.org/wiki/Factory_method_pattern
/*
 Фабричный метод — это порождающий паттерн проектирования, который решает проблему создания различных продуктов, без указания конкретных классов продуктов.
 (Источник: https://refactoring.guru/ru/design-patterns/factory-method/swift/example)
*/
protocol Product {
    func label() -> String
    func specifications() -> [String]
}

class Car: Product {
    func label() -> String { "Car" }
    func specifications() -> [String] { ["5 doors", "4 wheels", "donut"] }
}

class Motorcycle: Product {
    func label() -> String { "Motorcycle" }
    func specifications() -> [String] { ["2 wheels", "seat pad for ass"] }
}

protocol VehicleFactory {
    func label() -> Product
    func factoryMethod() -> Product
}

class CarFactory: VehicleFactory {
    func label() -> Product { Car() }
    func factoryMethod() -> Product { Car() }
}

class MotorcycleFactory: VehicleFactory {
    func label() -> Product { Motorcycle() }
    func factoryMethod() -> Product { Motorcycle() }
}

let car = CarFactory()
let moto = MotorcycleFactory()

let creators: [VehicleFactory] = [ car, moto ]

creators.forEach {
    let product = $0.factoryMethod()
    print("\(product.label()): \(product.specifications())")
}

// Skillbox
// Скиллбокс
