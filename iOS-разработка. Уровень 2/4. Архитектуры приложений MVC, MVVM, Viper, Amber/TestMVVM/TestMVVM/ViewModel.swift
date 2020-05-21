import Foundation
import Bond
import ReactiveKit

class ViewModel {
    let name = Observable("")
    
    // произойдет в следствии вызова updateGreeting
    let updateGreeting = Subject<Void, Never>()
    
    let greeting = Observable("")
    
    let users = MutableObservableArray([String()])
    
    init() {
        bind()
    }
    
    private func bind() {
        // подписываемся
        // только при вызове updateGreeting будет забираться последнее значение name и отправляться в greeting
        updateGreeting.with(latestFrom: name)
         .map { "Hello, \($1)" }.bind(to: greeting)
        
        //name.map { "Hello, \($0)" }.bind(to: greeting)
    }
}
