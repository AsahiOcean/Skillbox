/*
 Собственный аналог UISegmentControl, у которого всегда два возможных варианта сегмента;
 
 Выбранный элемент (по умолчанию первый) должен иметь цветную подложку, при нажатии на второй сегмент – эта подложка должна анимированно перемещаться под него и наоборот. В интерфейсе можно задать названия сегментов, цвет обводки и цвет подложки. Также он должен иметь делегат, через который будет сообщать о выбранном сегменте.
 */

import UIKit

protocol Delegate {
    func setSegment(_ SegmentLabel: String)
}

@IBDesignable class SegmentedControl: UIView {

    var isSetuped = false
    
    let First = UIView()
    let Second = UIView()
    let Podlozhka = UIView()
    
    var FirstLabel = UILabel()
    var SecondLabel = UILabel()
    
    var delegate: Delegate?

// MARK: -  Названия сегментов
    @IBInspectable var FirstName: String = "First" {
        didSet { FirstLabel.text = FirstName }
    }
    @IBInspectable var SecondName: String = "Second" {
        didSet { SecondLabel.text = SecondName }
    }
    
// MARK: - Подложка
    @IBInspectable var FirstColor: UIColor = UIColor.clear {
            didSet { First.backgroundColor = FirstColor
        }
    }
    @IBInspectable var SecondColor: UIColor = UIColor.clear {
            didSet { Second.backgroundColor = SecondColor
        }
    }
    @IBInspectable var PodlozhkaColor: UIColor = UIColor.systemGreen {
        didSet { Podlozhka.backgroundColor = PodlozhkaColor
        }
    }
    
// MARK: - Обводка
    @IBInspectable var CornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = CornerRadius
            layer.masksToBounds = CornerRadius > 0
        }
    }
    @IBInspectable var BorderWidth: CGFloat = 50 {
        didSet {
            layer.borderWidth = BorderWidth
        }
    }
    @IBInspectable var BorderColor: UIColor? {
        didSet {
            layer.borderColor = BorderColor?.cgColor
        }
    }
    
// MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        let H = frame.size.height
        let W = frame.size.width

// MARK: - First
        First.layer.frame = CGRect(x: 0, y: 0, width: W / 2, height: H)
        First.backgroundColor = FirstColor
// Label
        FirstLabel.layer.frame = CGRect(x: 0, y: 0, width: W / 2, height: H)
        FirstLabel.text = FirstName
        FirstLabel.textAlignment = .center
        FirstLabel.textColor = .black
        First.addSubview(FirstLabel)

// MARK: - Second
        Second.layer.frame = CGRect(x: W / 2, y: 0, width: W / 2, height: H)
        Second.backgroundColor = SecondColor
// Label
        SecondLabel.layer.frame = CGRect(x: 0, y: 0, width: W / 2, height: H)
        SecondLabel.text = SecondName
        SecondLabel.textAlignment = .center
        SecondLabel.textColor = .black
        Second.addSubview(SecondLabel)

// MARK: - Podlozhka
        
        Podlozhka.layer.frame = CGRect(x: 0, y: 0, width: W/2, height: H)
        Podlozhka.backgroundColor = PodlozhkaColor

        super.addSubview(Podlozhka)
        super.addSubview(First)
        super.addSubview(Second)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         if let touch = touches.first {
            // если нажат вью First
            if touch.view == self.First {
                UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
                    // центр подложки едет к центру First
                    self.Podlozhka.center = self.First.center
                }, completion: nil)
//                print("\(FirstLabel.text!)")
                delegate?.setSegment(FirstLabel.text!)
            }
            // если нажат вью Second
            else if touch.view == self.Second {
                UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
                    // центр подложки едет к центру Second
                    self.Podlozhka.center = self.Second.center
                }, completion: nil)
//                print("\(SecondLabel.text!)")
                delegate?.setSegment(SecondLabel.text!)
            } else {
                return
            }
        }
    }
}
