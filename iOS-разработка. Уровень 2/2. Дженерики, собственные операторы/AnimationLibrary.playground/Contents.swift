import UIKit
import Foundation
// Skillbox
// Скиллбокс

let view = UIView()
    
UIView.animate(withDuration: 0.3) {
    view.alpha = 0
}

protocol Animator {
    associatedtype Target
    associatedtype Value
 
    init(_ value: Value)
    
    func animate(target: Target)
}

class AlphaAnimator: Animator {

    let newValue: CGFloat
    
    required init(_ value: CGFloat) {
        newValue = value
    }
    
    func animate(target: UIView) {
        UIView.animate(withDuration: 0.3) {
            target.alpha = 0
        }
    }
}

infix operator ~>
func ~><T: Animator>(left: T, right: T.Target) {
    left.animate(target: right)
}
AlphaAnimator(0) ~> view
