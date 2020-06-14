import UIKit
//3) используя object association, добавьте к UIView свойство @IBInspectable var identifier: String

private var IDstring: String = ""
extension UIView {
    @IBInspectable var identifier: String {
        get { objc_getAssociatedObject(self, &IDstring) as! String }
        set { objc_setAssociatedObject(self, &IDstring, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }
}
