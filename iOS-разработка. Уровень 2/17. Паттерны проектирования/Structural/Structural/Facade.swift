import Foundation
// Skillbox
// Материал из урока
// Структурные паттерны проектирования: Фасад (Facade pattern)

// Из урока: "Создание более удобного взаимодействия с существующим сервисом"
class Defaults {
    static let shared = Defaults()
    
    private let defs = UserDefaults.standard
    
    subscript(key: String) -> String? {
        get { return defs.string(forKey: key) }
        set { defs.set(newValue, forKey: key) }
    }
}

class FacadeTest {
    func test() {
        Defaults.shared["test"] = "qweqweq"
        
        let a = Defaults.shared["test"]
    }
}
