import Foundation

// посредник между контроллером и интерактором
// берет данные из интерактора

class ToDoPresenter: ToDoPresenterProtocol, TodoInteractorOutputProtocol {
/*
     https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html
          
     ссылку можно пометить как unowned, тогда она и экземпляр,
     который она захватывает будут освобождаться в одно и то же время.
     
     стоит быть увереным, что экземпляр будет что-то содержать
*/
    unowned var view: ToDoViewProtocol!
    var interactor: TodoInteractorInputProtocol?
    var router: ToDoRouterProtocol?
    
    func get() { // viewDidLoad
        self.interactor?.get()
    }
    
    func add(_ todo: String) {
        self.interactor?.add(todo); self.get()
    }
    
    func remove(_ id: Int) {
        self.interactor?.remove(id); self.get()
    }
    
    func todoList(_ todolist: [String]) {
        self.view?.showMe(todolist)
    }
    
    init() { print(">> Presenter добавлен в память") }
    deinit { print("<<< Presenter удален из памяти!") }
}
