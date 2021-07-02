import Foundation

// Материал из урока
// Структурные паттерны проектирования: Компоновщик (Composite pattern)

protocol Shape {
    func draw(color: String)
}

final class Square: Shape {
    func draw(color: String) {
        print("Square! Color: \(color)")
    }
}

final class Circle: Shape {
    func draw(color: String) {
        print("Circle! Color: \(color)")
    }
}

final class WhiteBoard: Shape {
    private var shapes: [Shape] = []
    
    init(shapes: [Shape]) {
        self.shapes = shapes
    }
    
    func drawShape(shape: Shape) {
        shapes.append(shape)
    }
    
    func draw(color: String) {
        for s in shapes {
            s.draw(color: color)
        }
    }
}
