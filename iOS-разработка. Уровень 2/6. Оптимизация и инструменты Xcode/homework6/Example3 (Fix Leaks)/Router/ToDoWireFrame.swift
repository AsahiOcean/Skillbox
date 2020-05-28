import Foundation

// здесь все связывается в одно целое

class ToDoRouter: ToDoRouterProtocol {
    class func controller(_ ref: Example3_ViewController) {
        let presenter: ToDoPresenterProtocol & TodoInteractorOutputProtocol = ToDoPresenter()
        ref.presenter = presenter
        ref.presenter?.router = ToDoRouter()
        ref.presenter?.view = ref
        ref.presenter?.interactor = TodoInteractor()
        ref.presenter?.interactor?.presenter = presenter
    }
    init() { print(">> Router в добавлен в память") }
    deinit { print("<<< Router удален из памяти!") }
}
