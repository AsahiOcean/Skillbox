import Foundation
// Skillbox
// Материал из урока
// Порождающие паттерны проектирования: Одиночка (Singleton pattern)

class API {
    static let shared = API()
    
    private init() {
        
    }
    
    func interact() {
        
    }
}

class test2 {
    func test() {
        API.shared.interact()
    }
}
