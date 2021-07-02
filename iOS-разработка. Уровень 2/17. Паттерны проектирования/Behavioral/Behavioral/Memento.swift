import Foundation
import UIKit

// Материал из урока
// Поведенческие паттерны проектирования: Хранитель/снимок (Memento pattern)

struct Checkpoint { // <- Memento
    let playerPosition: CGPoint
    let level: Int
}

class Game {
    
    func createCheckpoint() -> Checkpoint {
        fatalError()
    }
    
    func loadCheckpoint(memento: Checkpoint) {
        // load & update checkpoint
        
        // "Загружаем нужное из массива состояний (Checkpoint)"
    }
}
