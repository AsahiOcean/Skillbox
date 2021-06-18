import UIKit

// MARK: -- прочитайте статью про утечку памяти:
//https://hackernoon.com/swift-avoiding-memory-leaks-by-examples-f901883d96e5
// MARK: -- изучите инструменты, которые есть в Xcode:
//https://www.raywenderlich.com/397-instruments-tutorial-with-swift-getting-started
//MARK: Blank: туда можно указать за чем необходимо следить
//MARK: Activity Monitor: следит за использованием ресурсов
//MARK: Allocation: следит за виртуальной памятью
//MARK: App Launch: отладка запуска приложения
//MARK: Core Animation: проверка производительности графики
//MARK: Core Data: отладка использования core data
//MARK: Counters: детальный мониторинг производительности
//MARK: Energy Log: мониторинг потребления энергии каждого компонента устройства (будь то вью-элемент или GPS)
//MARK: File Activity: мониторинг использования файловой системы и ROM
//MARK: Game Performance: мониторинг игрового движка
//MARK: -- Leaks: отслеживание утечек памяти
//MARK: Metal System Trace: мониторинг производительности для Metal
//MARK: Network: анализ трафика в сеть
//MARK: SceneKit: мониторинг использования графики у игровых сцен
//MARK: SwiftUI: мониторинг потребления ресурсов вью-элементами
//MARK: System Trace: чуть более детальный лог :)
//MARK: Time Profile: подсчет времени выполнения работы каждого участка кода (рекомендуется использовать на реальных устройствах)
//MARK: Zombies: отладка ошибок памяти из-за неправильной логики в коде

// MARK: напишите как можно больше примеров (с кодом) в которых по-разному создаются утечки памяти
// коммент по TODO VIPER: по причине делегирования полномочий на модули в память загружается каждый из них, при очередном использовании того же TODO все модули будут загружаться еще раз

//MARK: задание: что нужно сделать, чтобы во время выполнения программы вывести значение любого свойства или функции?
// установить брейкпоинт на это значение или функцию
// Edit breakpoint -> Debugger Command -> po name

//MARK: задание: что нужно сделать, чтобы во время выполнения программы поменять значение у любого свойства?
// Edit breakpoint -> Debugger Command -> expression self.Name = "new"

// как с помощью брейкпоинтов отслеживать изменения значений у выбранного свойства?
// установить брейкпоинт на нужное значение и в консоли указать (Watch "name")

// как отслеживать вызов системных функций?
// через Profile -> Time Profile

class ViewController: UIViewController, Example1Delegate {
    private var Name = "ViewController"
    private var example1 = Example1()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(">> \(Name) добавлен в память")
        // MARK: Пример 0
        let A = ARC_A()
        let B = ARC_B()
        A.b = B // при nil - удалит из памяти
        B.a = A
        
        // MARK: Пример 1
        example1.delegate = self
        
        // memoryReport
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
        self.title = ByteCountFormatter().string(fromByteCount: Int64(memoryReport()))
        }
    }
    deinit { print("<<< \(Name) удален из памяти!")}
}
class ARC_A {
    var b: ARC_B!
    init() { print(">> ARC_A добавлен в память"); refCount0 += 1}
    deinit { print("<<< ARC_A удален из памяти!"); refCount0 -= 1}
}
class ARC_B {
    var a: ARC_A!
    init() { print(">> ARC_B добавлен в память"); refCount0 += 1 }
    deinit { print("<<< ARC_B удален из памяти!"); refCount0 -= 1}
}
//MARK: -- refCount0
public var refCount0 = 0 {
    didSet {
        if refCount0 > 1 {
            print("*** ARC УТЕЧЕК: \(refCount0 - 1) ***")
        }
    }
}
