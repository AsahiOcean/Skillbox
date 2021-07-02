import Foundation

// Материал из урока
// Структурные паттерны проектирования: Адаптер (Adapter pattern)

class WeightData {
    var weights: [Double] = []
}

class GraphData {
    func getPoints() -> [Double] {
        return []
    }
}

class WeightDataAdapter: GraphData {
    let data: WeightData
    
    init(data: WeightData) {
        self.data = data
    }
    
    override func getPoints() -> [Double] {
        return data.weights
    }
}

/*
 Примечание из урока:
 "Чуть более изящная реализация, которая возможна за счет расширения классов и реализацией протоколов"
 */
protocol GraphDataProtocol {
    func getPoints() -> [Double]
}

extension WeightData: GraphDataProtocol {
    func getPoints() -> [Double] {
        return weights
    }
}

class Graphic {
    func draw(data: GraphData) {
        //draw
    }
}
