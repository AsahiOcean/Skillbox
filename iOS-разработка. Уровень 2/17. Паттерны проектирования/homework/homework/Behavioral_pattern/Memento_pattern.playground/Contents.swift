// https://ru.wikipedia.org/wiki/Хранитель_(шаблон_проектирования)
// https://en.wikipedia.org/wiki/Memento_pattern
/*
 Снимок — это поведенческий паттерн, позволяющий делать снимки внутреннего состояния объектов, а затем восстанавливать их.
 При этом Снимок не раскрывает подробностей реализации объектов, и клиент не имеет доступа к защищённой информации объекта.
 (Источник: https://refactoring.guru/ru/design-patterns/memento/swift/example)
*/

import Foundation
import UIKit

struct Property {
    let x: Int
    //let x: Int, y: Int
}

/// Создатель
class Originator {
    // private(set) - приватное свойство которое может быть установлено, только в пределах данного метода
    private(set) var posArr: [Property] = []
    
    var description: String {
        posArr.reduce("Positions: ", { "\($0)[\($1.x)]" })
    }
    
    func move(pos: [Property]) {
        posArr.append(contentsOf: pos) // присоединяем новую последовательность шагов к массиву
        print(self.description) // вывод в лог
    }
    
    func saveState() -> States {
        Memento(points: posArr)
    }
    
    func restore(states: States) {
        posArr = states.position
    }
}

protocol States {
    var position: [Property] { get }
}

/// Хранитель
class Memento: States {
    private(set) var position: [Property] = []
    
    init(points: [Property]) {
        self.position = points
    }
}

/// Опекун
class Caretaker {
    private(set) var states: [States] = []
    private(set) var curIndex: Int = 0
    private let originator: Originator
    
    init(originator: Originator) {
        self.originator = originator
    }
    
    internal func save() {
        // проверяем где на данный момент находится текущий индекс
        let endIndex = states.count - 1 - curIndex
        if endIndex > 0 { states.removeLast(endIndex) }
        
        states.append(originator.saveState())
        curIndex = states.count - 1
        print("Save! -> \(originator.description)")
    }
    /// возвращаемся на указаную позицию
    internal func back(at state: Int) {
        guard state <= curIndex else { return }
        
        curIndex -= state
        originator.restore(states: states[curIndex])
        print("Back at \(state) pos: \(originator.description)")
    }
    /// восстанавливаем указаную позицию
    internal func restore(state: Int) {
        let newIndex = curIndex + state
        //guard newIndex < states.count - 1 else { return }

        curIndex = newIndex
        originator.restore(states: states[curIndex])
        print("Restore pos: \(state)! >>> \(originator.description)")
    }
}

let originator = Originator()
let caretaker = Caretaker(originator: originator)

originator.move(pos: [Property(x:0), Property(x:1)])
caretaker.save()

originator.move(pos: [Property(x:2), Property(x:3)])
caretaker.save()

originator.move(pos: [Property(x:4), Property(x:5)])
caretaker.save()

caretaker.back(at: 2) // возвращаемся на указаную позицию
caretaker.restore(state: 1) // восстанавливаем указаную позицию

originator.move(pos: [Property(x: 10)])
caretaker.save()

caretaker.back(at: 2)

// Skillbox
// Скиллбокс
