/*
  кнопка, у которой можно изменять ширину и цвет обводки, размер закругления
 */

import UIKit

class Button: UIButton {

}

@IBDesignable extension Button {

    @IBInspectable var BorderWidth: CGFloat {
// получает значение
        get {
            layer.borderWidth
        }
// устанавливаем новое значение
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var CornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable var BorderColor: UIColor? {
        get {
// действительно ли cgColor = layer.borderColor
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            guard let UIColor = newValue else { return }
            layer.borderColor = UIColor.cgColor
        }
    }
}
