import Foundation
// Skillbox
// Материал из урока
// Поведенческие паттерны проектирования: Стратегия (Strategy pattern)

protocol SearchStrategy {
    func indexOf(el: String, inArray array: [String]) -> Int?
}

// Бинарный поиск может происходить только в отсортированном массиве
class BinarySearch {
    func indexOf(el: String, inArray array: [String]) -> Int? {
        return nil
    }
}

// Линейный поиск может происходить в любом массиве
class LinearSearch: SearchStrategy {
    func indexOf(el: String, inArray array: [String]) -> Int? {
        return nil
    }
}

class SearchPerformer {
    let strategy: SearchStrategy
    
    init(strategy: SearchStrategy) {
        self.strategy = strategy
    }
    
    func indexOf(el: String, inArray array: [String]) -> Int? {
        strategy.indexOf(el: el, inArray: array)
    }
}
