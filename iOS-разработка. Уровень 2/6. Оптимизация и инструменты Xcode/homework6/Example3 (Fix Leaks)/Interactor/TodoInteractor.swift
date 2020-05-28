import Foundation

class TodoInteractor: TodoInteractorInputProtocol {
/*
     https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html
              
     ссылку можно пометить как unowned, тогда она и экземпляр,
     который она захватывает будут освобождаться в одно и то же время.
         
     стоит быть увереным, что экземпляр будет что-то содержать
*/
        unowned var presenter: TodoInteractorOutputProtocol?
        
        func get() {
            self.presenter?.todoList(getter())
        }
        private func getter() -> [String] {
            var array = [String()]
            for i in todolist.indices {
                array.append(todolist[i])
            }
            return array.reversed().dropLast()
        }
        
        func add(_ todo: String) {
            todolist.append(todo)
        }
        
        func remove(_ i: Int) {
            todolist.remove(at: i)
        }
    init() { print(">> Interactor в добавлен в память") }
    deinit { print("<<< Interactor удален из памяти!") }
}
