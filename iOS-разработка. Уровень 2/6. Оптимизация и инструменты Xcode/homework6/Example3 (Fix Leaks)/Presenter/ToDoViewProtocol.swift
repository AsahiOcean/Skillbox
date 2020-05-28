import Foundation

protocol ToDoViewProtocol: class {
    func showMe(_ todolist: [String])
}

protocol TodoInteractorOutputProtocol: class {
    func todoList(_ todolist: [String])
}

protocol TodoInteractorInputProtocol: class {
    var presenter: TodoInteractorOutputProtocol? { get set }
    
    func get()
    func add(_ todo: String)
    func remove(_ id: Int)
}

protocol ToDoRouterProtocol: class { }

protocol ToDoPresenterProtocol: class {
    var view: ToDoViewProtocol! { get set }
    var interactor: TodoInteractorInputProtocol? { get set }
    var router: ToDoRouterProtocol? { get set }
    
    func get()
    func add(_ todo: String)
    func remove(_ id: Int)
}
