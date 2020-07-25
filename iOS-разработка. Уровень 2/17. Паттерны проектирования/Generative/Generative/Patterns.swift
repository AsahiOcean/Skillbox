import Foundation
// Skillbox
// Материал из урока
// Порождающие паттерны проектирования: Абстрактная фабрика (Abstract factory pattern)

protocol ViewElement {
    func draw()
}

class iOSButton: ViewElement {
    func draw() {
        print("IOSButton")
    }
}

class tvOSButton: ViewElement {
    func draw() {
        print("TVOSButton")
    }
}

class iOSCheckbox: ViewElement {
    func draw() {
        print("iOSCheckbox")
    }
}

class tvOSCheckbox: ViewElement {
    func draw() {
        print("tvOSCheckbox")
    }
}

protocol UIFabric {
    func createButton() -> ViewElement
    func createCheckbox() -> ViewElement
}

class IOSFabric: UIFabric {
    func createButton() -> ViewElement {
        return iOSButton()
    }
    func createCheckbox() -> ViewElement {
        return iOSCheckbox()
    }
}

class TVOSFabric: UIFabric {
    func createButton() -> ViewElement {
        return tvOSButton()
    }
    func createCheckbox() -> ViewElement {
        return tvOSCheckbox()
    }
}

class ElementFabric: UIFabric {
    func createButton() -> ViewElement {
        return fabric.createButton()
    }
    
    func createCheckbox() -> ViewElement {
        return fabric.createCheckbox()
    }
    
    let fabric: UIFabric
    
    init(fabric: UIFabric) {
        self.fabric = fabric
    }
    
    static func create() -> ElementFabric {
        let os = "iOS"
        switch os {
        case "iOS":
            return ElementFabric(fabric: IOSFabric())
        case "tvOS":
            return ElementFabric(fabric: TVOSFabric())
        default:
            fatalError("Unsupported")
        }
    }
}
