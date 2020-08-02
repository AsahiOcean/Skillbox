// https://ru.wikipedia.org/wiki/Адаптер_(шаблон_проектирования)
// https://en.wikipedia.org/wiki/Adapter_pattern
/*
 Адаптер — это структурный паттерн, который позволяет подружить несовместимые объекты.
 Адаптер выступает прослойкой между двумя объектами, превращая вызовы одного в вызовы понятные другому.
 (Источник: https://refactoring.guru/ru/design-patterns/adapter/swift/example)
*/

import Foundation

// Target объявляет интерфейс, с которым может работать Client
class Target {
    internal var dateFormat = "dd.MM.YYYY HH:mm"
    
    func request() -> String {
        return "Target: предлагаю работать с типом \(dateFormat)"
    }
}

// Адаптируемый класс. Его интерфейс несовместим с клиентом и нуждается в адаптации перед использованием
class Adaptee {
    func specificRequest() -> Int {
        return Int(Date().timeIntervalSince1970)
    }
}

// Adapter делает интерфейс адаптируемого класса (Adaptee) совместимым с интерфейсом
class Adapter: Target {

    private var adaptee: Adaptee
    
    init(_ adaptee: Adaptee) {
        self.adaptee = adaptee
    }
    
    override func request() -> String {
        //MARK: здесь происходит адаптация
        let date = Date(timeIntervalSince1970: TimeInterval(self.adaptee.specificRequest()))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = NSLocale.autoupdatingCurrent
        dateFormatter.dateFormat = self.dateFormat
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
}

class Client {
    internal static func execute(target: Target) {
        print(target.request())
    }
}

// Реализуем шаблон
class AdapterConceptual {
    func testAdapterConceptual() {
        print("Client: получены данные с датой! Обращаемся к Target за инструкцией!")
        Client.execute(target: Target())

        let adaptee = Adaptee()
        print("Client: у Adaptee странный формат, не могу применить инструкцию")
        print("Adaptee: " + adaptee.specificRequest().description)

        print("Client: попробую применить Adapter:")
        Client.execute(target: Adapter(adaptee))
    }
}

let test = AdapterConceptual()
_ = test.testAdapterConceptual()

// Skillbox
// Скиллбокс
