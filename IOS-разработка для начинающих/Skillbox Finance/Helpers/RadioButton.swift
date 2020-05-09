import Foundation
import UIKit

@IBDesignable
public class KGRadioButton: UIButton {
    internal var OuterCircle = CAShapeLayer()
    internal var InnerCircle = CAShapeLayer()
    
    @IBInspectable public var outerCircleColor: UIColor = UIColor.green {
    didSet { OuterCircle.strokeColor = outerCircleColor.cgColor }
    }
    @IBInspectable public var innerCircleCircleColor: UIColor = UIColor.green { didSet { setFillState() }
    }
    @IBInspectable public var outerCircleLineWidth: CGFloat = 3.0 {
    didSet { setCircleLayouts() }
    }
    @IBInspectable public var innerCircleGap: CGFloat = 3.0 {
    didSet { setCircleLayouts() }
    }
    override public init(frame: CGRect) {
    super.init(frame: frame); customInitialization()
    }
    required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder); customInitialization()
    }
    internal var setCircleRadius: CGFloat {
    let (w,h) = (bounds.width,bounds.height)
    let length = w > h ? h : w
        return (length - outerCircleLineWidth) / 2
    }
    private var setCircleFrame: CGRect {
    let (w,h) = (bounds.width,bounds.height)
    let r = setCircleRadius
    let x: CGFloat; let y: CGFloat
    if w > h { y = outerCircleLineWidth / 2; x = (w / 2) - r
    } else { x = outerCircleLineWidth / 2; y = (h / 2) - r
    }
    let d = 2 * r
    return CGRect(x: x, y: y, width: d, height: d)
    }
    private var circlePath: UIBezierPath {
    return UIBezierPath(roundedRect: setCircleFrame, cornerRadius:setCircleRadius)
    }
    private var fillCirclePath: UIBezierPath {
        let trueGap = innerCircleGap + (outerCircleLineWidth / 2)
        return UIBezierPath(roundedRect: setCircleFrame.insetBy(dx: trueGap, dy: trueGap), cornerRadius: setCircleRadius)
    }
    
    private func customInitialization() {
        OuterCircle.frame = bounds
        OuterCircle.lineWidth = outerCircleLineWidth
        OuterCircle.fillColor = UIColor.clear.cgColor
        OuterCircle.strokeColor = outerCircleColor.cgColor
        layer.addSublayer(OuterCircle)
        InnerCircle.frame = bounds
        InnerCircle.lineWidth = outerCircleLineWidth
        InnerCircle.fillColor = UIColor.clear.cgColor
        InnerCircle.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(InnerCircle)
        setFillState()
    }
    
    private func setCircleLayouts() {
        OuterCircle.frame = bounds
        OuterCircle.lineWidth = outerCircleLineWidth
        OuterCircle.path = circlePath.cgPath
        InnerCircle.frame = bounds
        InnerCircle.lineWidth = outerCircleLineWidth
        InnerCircle.path = fillCirclePath.cgPath
    }
    
    private func setFillState() {
    if self.isSelected { InnerCircle.fillColor = outerCircleColor.cgColor
    } else { InnerCircle.fillColor = UIColor.clear.cgColor }
    }

    override public func prepareForInterfaceBuilder() {
        customInitialization()
    }
    override public func layoutSubviews() {
    super.layoutSubviews(); setCircleLayouts()
    }
    override public var isSelected: Bool {
    didSet { setFillState() }
    }
}
