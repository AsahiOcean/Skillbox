import Foundation

// Материал из урока
// Порождающие паттерны проектирования: Одиночка (Singleton pattern)

class API {
    static let shared = API()
    
    func interact() {
        
    }
    
    fileprivate init() { }
    
}

class test2 {
    func test() {
        API.shared.interact()
    }
}
