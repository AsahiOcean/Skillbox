// https://ru.wikipedia.org/wiki/Команда_(шаблон_проектирования)
// https://en.wikipedia.org/wiki/Command_pattern

/*
 Команда — это поведенческий паттерн, позволяющий заворачивать запросы или простые операции в отдельные объекты.
 Это позволяет откладывать выполнение команд, выстраивать их в очереди, а также хранить историю и делать отмену.
 (Источник: https://refactoring.guru/ru/design-patterns/command/swift/example)

 Этот паттерн можно использовать когда нужно передавать в качестве параметров определенные методы, вызываемые в ответ на другие действия.
*/

import Foundation

protocol Command {
    mutating func execute()
    mutating func undo()
}

// Receiver принимает команды и определяет методы, которые в итоге должны выполняться
class Receiver {
    private var test: [String] = []
    func action() {
        print("run: \(type(of: self)).action()")
        print("Adding elements...")
        for item in 1...3 {
            test.append(item.description)
            print(test.map{$0})
            usleep(250000)
        }
    }
    func cancel() {
        print("run: \(type(of: self)).cancel()")
        print("Removing elements...")
        repeat {
            print(test.map{$0})
            test.removeLast()
            usleep(250000)
        } while test.count > 0
    }
}

// ConcreteCommand знает о Receiver и вызывает метод invoker
// реализует метод execute(), в котором вызывается метод из класса Receiver
class ConcreteCommand: Command {
    private let receiver: Receiver
    
    init(receiver: Receiver) {
        print("\(type(of: self)) init!")
        self.receiver = receiver
    }
    func execute() {
        print("run: \(type(of: self)).execute()")
        self.receiver.action()
    }
    func undo() {
        print("run: \(type(of: self)).undo()")
        self.receiver.cancel()
    }
}

// Invoker знает, как выполнить команду, а также может вести учёт выполненных команд
// При этом он ничего не знает о конкретной команде, он знает только об интерфейсе
class Invoker {
    private var commands: [Command] = []
    
    func setCommand(cmd: Command) {
        print("run: \(type(of: self)).setCommand")
        self.commands.append(cmd)
    }
    func invokeStart() {
        print("\nrun: \(type(of: self)).invokeStart [commands: \(self.commands.count)]")
        for index in 0..<commands.count {
            self.commands[index].execute()
        }
    }
    func invokeStop() {
        print("\nrun: \(type(of: self)).invokeStop [commands: \(self.commands.count)]")
        for index in 0..<commands.count {
            self.commands[index].undo()
        }
    }
}

// Client решает, какие команды выполнить и когда + устанавливает ее получателя с помощью метода SetCommand()
class Client {
    func test() {
        let invoker = Invoker()
        let receiver = Receiver()
        let concreteCommand = ConcreteCommand(receiver: receiver)
        // передает объект команды вызывающему объекту (invoker)
        invoker.setCommand(cmd: concreteCommand)
        invoker.invokeStart()
        invoker.invokeStop()
    }
}

let client = Client()
client.test()

// Skillbox
// Скиллбокс
