import Foundation

protocol PresenterInput: class {
    var output: PresenterOutput! { get set }
    
    func nameUpdated(name: String)
}

protocol PresenterOutput {
    func updateGreeting(greeting: String)
}


// связующее звено между ViewController и (Interactor + Router)
class Presenter: PresenterInput {
    // weak - чтобы не получилось замыкания
    var output: PresenterOutput!
    
    var interactor: InteractorInput! = Interactor()
    var router: RouterInput! = Router()
    
    func nameUpdated(name: String) {
        output.updateGreeting(greeting: interactor.greetingForName(name: name))
    }
}
extension Presenter: InteractorOutput, RouterOutput {
    
}
