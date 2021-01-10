import Foundation

protocol InteractorInput {
    // все что Interactor будет делать прописывается здесь
    func greetingForName(name: String) -> String
}

protocol InteractorOutput {
    // данные которые Interactor возвращает прописываются здесь
    
}

// взаимодействует в разными модулями, типа сервера или базы данных
// из Presenter получает запрос на то, чтобы что-то сделать
class Interactor: InteractorInput {
    func greetingForName(name: String) -> String {
        return name.isEmpty ? "" : "Hello, \(name)"
    }
}
