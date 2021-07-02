import Foundation

// Материал из урока
// Поведенческие паттерны проектирования: Команда (Command pattern)

class Door {
    var name = ""
}

protocol DoorCommand {
    func execute(door: Door)
}

class OpenDoorCommand: DoorCommand {
    func execute(door: Door) {
        print("Open door!")
    }
}

class CloseDoorCommand: DoorCommand {
    func execute(door: Door) {
        print("Close door!")
    }
}

typealias DoorCommandAlias = (Door) -> Void
func OpenCommand() -> DoorCommandAlias {
    return { d in print("Open: \(d.name)") }
}
func CloseCommand() -> DoorCommandAlias {
    return { d in print("close: \(d.name)") }
}

let openCommand: DoorCommandAlias = { d in print("Open: \(d.name)") }
let closeCommand: DoorCommandAlias = { d in print("close: \(d.name)") }



class DoorOperations {
    let door: Door
    private let openCommand = OpenDoorCommand()
    private let closeCommand = CloseDoorCommand()

    // DoorCommandAlias
    private let openCommand2 = OpenCommand()
    private let closeCommand2 = CloseCommand()

    init(door: Door) {
        self.door = door
    }
    
    func open() {
        openCommand.execute(door: door)
        openCommand2(door)
    }
    
    func close() {
        closeCommand.execute(door: door)
        closeCommand2(door)
    }
}


