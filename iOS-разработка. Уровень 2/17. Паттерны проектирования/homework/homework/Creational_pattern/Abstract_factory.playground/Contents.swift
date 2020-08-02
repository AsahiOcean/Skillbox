// https://ru.wikipedia.org/wiki/Абстрактная_фабрика_(шаблон_проектирования)
// https://en.wikipedia.org/wiki/Abstract_factory_pattern
/*
 Абстрактная фабрика — это порождающий паттерн проектирования, который решает проблему создания целых семейств связанных продуктов, без указания конкретных классов продуктов.

 Абстрактная фабрика задаёт интерфейс создания всех доступных типов продуктов, а каждая конкретная реализация фабрики порождает продукты одной из вариаций. Клиентский код вызывает методы фабрики для получения продуктов, вместо самостоятельного создания с помощью оператора new. При этом фабрика сама следит за тем, чтобы создать продукт нужной вариации.
 
 (Источник: https://refactoring.guru/ru/design-patterns/abstract-factory/swift/example)
*/
//MARK: -- Абстрактная фабрика (Abstract Factory)
// определям методы для создания объектов. Методы будут возвращать абстрактные продукты, а не их реализацию.
protocol AbstractFactory {
    func getMoney() -> Money
    func getCrypto() -> Crypto
}

//MARK: -- Классы фабрик (Concrete Factory)
// реалиция методов из AbstractFactory и определяем какие конкретные продукты использовать

class ConcreteFactory1: AbstractFactory { // фабрика обмена RUR <-> Bitcoin
    func getMoney() -> Money { RUR() }
    func getCrypto() -> Crypto { Bitcoin() }
}
class ConcreteFactory2 : AbstractFactory { // фабрика обмена Ethereum <-> USD
    func getMoney() -> Money { USD() }
    func getCrypto() -> Crypto { Ethereum() }
}

// определяем интерфейс для классов, объекты которых будут создаваться
protocol Money { func exchange(to: Crypto) }
protocol Crypto { func exchange(to: Money) }

//MARK: -- Конкретные классы
// здесь происходит реализация абстрактных классов

class RUR: Money {
    func exchange(to: Crypto) {
        print("\(type(of: self)) exchange for \(type(of: to.self))")
    }
}
class USD: Money {
    func exchange(to: Crypto) {
        print("\(type(of: self)) exchange for \(type(of: to.self))")
    }
}
class Bitcoin: Crypto {
    func exchange(to: Money) {
        print("\(type(of: self)) exchange for \(type(of: to.self))")
    }
    
}
class Ethereum: Crypto {
    func exchange(to: Money) {
        print("\(type(of: self)) exchange for \(type(of: to.self))")
    }
}

//MARK: -- Класс клиента
// в клиенте происходит взаимодействие между объектами

//MARK: представим, что клиент это обменник на криптовалюту для нашего любимого сайта
class Client { // <- money exchanger
    private let money: Money
    private let crypto: Crypto

    // Конструктор использует абстрактную фабрику для создания объектов
    init(factory: AbstractFactory) {
        self.money = factory.getMoney()
        self.crypto = factory.getCrypto()
    }

    func getCrypto() { money.exchange(to: crypto) }
    func getMoney() { crypto.exchange(to: money) }
}
// Вызов абстрактной фабрики № 1 (RUR <-> Bitcoin)
let factory1 = ConcreteFactory1()
let client1 = Client(factory: factory1)
client1.getCrypto()
client1.getMoney()

// Вызов абстрактной фабрики № 2 (Ethereum <-> USD)
let factory2 = ConcreteFactory2()
let client2 = Client(factory: factory2)
client2.getMoney()

// Skillbox
// Скиллбокс
