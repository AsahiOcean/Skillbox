/*
  Часы с часовой, минутной и секундной стрелкой, у которых можно менять цвет и размер каждой стрелки
 */
// Skillbox
// Скиллбокс

import UIKit

@IBDesignable class Clock: UIView {

    var isSetuped = false
    
// MARK: - Стрелки
    
    private let HourHand = UIView()
    private let MinuteHand = UIView()
    private let SecondsHand = UIView()

//  Ширина
    @IBInspectable var HourHandWidth: CGFloat = 6 {
            didSet { _ = HourHand.layer.frame.width }
    }
    @IBInspectable var MinuteHandWidth: CGFloat = 4 {
            didSet { _ = MinuteHand.layer.frame.width }
    }
    @IBInspectable var SecondsHandWidth: CGFloat = 2 {
            didSet { _ = SecondsHand.layer.frame.width }
    }
// Длина
// чем больше число - тем ниже стрелка
    @IBInspectable var HourHandHeight: CGFloat = 60 {
        didSet { _ = HourHand.layer.frame.height }
        }
    @IBInspectable var MinuteHandHeight: CGFloat = 40 {
        didSet { _ = MinuteHand.layer.frame.height }
        }
    @IBInspectable var SecondsHandHeight: CGFloat = 20 {
        didSet { _ = SecondsHand.layer.frame.height }
        }
//  Цвет
    @IBInspectable var HourHandColor: UIColor = UIColor.green {
        didSet { HourHand.backgroundColor = HourHandColor }
    }
    @IBInspectable var MinuteHandColor: UIColor = UIColor.blue {
        didSet { MinuteHand.backgroundColor = MinuteHandColor }
    }
    @IBInspectable var SecondsHandColor: UIColor = UIColor.red {
        didSet { SecondsHand.backgroundColor = SecondsHandColor }
    }
// MARK: - Деления циферблата
    let HourMarkerWidth: CGFloat = 5
    let HourMarkerHeight: CGFloat = 15
// Цвет
    let HourMarkerColor: UIColor = UIColor.black
// UIView
    private let HourMarkerUp = UIView()
    private let HourMarkerLeft = UIView()
    private let HourMarkerRight = UIView()
    private let HourMarkerBottom = UIView()
    
// MARK: - Сколько время?
    @IBInspectable var Hours: CGFloat = 12 {
        didSet { layoutIfNeeded() }
    }
    @IBInspectable var Minutes: CGFloat = 60 {
        didSet { layoutIfNeeded() }
    }
    @IBInspectable var Seconds: CGFloat = 60 {
        didSet { layoutIfNeeded() }
    }

// MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
// Размеры фрейма
        let W = frame.size.width
        let H = frame.size.height

// Приоритет
        HourHand.layer.zPosition = 3
        MinuteHand.layer.zPosition = 2
        SecondsHand.layer.zPosition = 1

// anchorPoint
        HourHand.layer.anchorPoint = CGPoint(x: 0, y: 1)
        MinuteHand.layer.anchorPoint = CGPoint(x: 0, y: 1)
        SecondsHand.layer.anchorPoint = CGPoint(x: 0, y: 1)

// СТРЕЛКИ: размеры и координаты
        HourHand.frame = CGRect(x: W / 2 - HourHandWidth, y: HourHandHeight, width: HourHandWidth, height: H / 2 - HourHandHeight)
        MinuteHand.frame = CGRect(x: W / 2 - MinuteHandWidth, y: MinuteHandHeight, width: MinuteHandWidth, height: H / 2 - MinuteHandHeight )
        SecondsHand.frame = CGRect(x: W / 2 - SecondsHandWidth, y: SecondsHandHeight, width: SecondsHandWidth, height: H / 2 - SecondsHandHeight )
// Цвет стрелок
        HourHand.backgroundColor = HourHandColor
        MinuteHand.backgroundColor = MinuteHandColor
        SecondsHand.backgroundColor = SecondsHandColor

// Размер и позиция делений циферблата
        HourMarkerUp.frame = CGRect(x: W / 2 - HourMarkerWidth, y: 0, width: HourMarkerWidth, height: HourMarkerHeight)
        
        HourMarkerLeft.frame = CGRect(x: 0, y: H / 2 - HourMarkerWidth, width: HourMarkerHeight, height: HourMarkerWidth)
        
        HourMarkerRight.frame = CGRect(x: W - HourMarkerHeight, y: H / 2 - HourMarkerWidth, width: HourMarkerHeight, height: HourMarkerWidth)
        
        HourMarkerBottom.frame = CGRect(x: H / 2 - HourMarkerWidth, y: H - HourMarkerHeight, width: HourMarkerWidth, height: HourMarkerHeight)
        
// Круглый циферблат
        layer.cornerRadius = frame.size.width / 2

// MARK: - Создаем элементы
        for element in [HourMarkerUp, HourMarkerLeft, HourMarkerRight, HourMarkerBottom] {
            element.backgroundColor = HourMarkerColor
            addSubview(element)
            addSubview(HourHand)
            addSubview(MinuteHand)
            addSubview(SecondsHand)
        }
        
        if isSetuped { return }
        isSetuped = true
        
        ChangeHours()
        ChangeMinutes()
        ChangeSeconds()
        
    }
    func ChangeHours() {
        let hours = CGFloat.pi * 2 * (Hours / (CGFloat(12)))
        HourHand.transform = CGAffineTransform(rotationAngle: hours)
    }
    func ChangeMinutes() {
        let minutes = CGFloat.pi * 2 * (Minutes / (CGFloat(60)))
        MinuteHand.transform = CGAffineTransform(rotationAngle: minutes)
    }
    func ChangeSeconds() {
        let seconds = CGFloat.pi * 2 * (Seconds / (CGFloat(60)))
        SecondsHand.transform = CGAffineTransform(rotationAngle: seconds)
    }
}
