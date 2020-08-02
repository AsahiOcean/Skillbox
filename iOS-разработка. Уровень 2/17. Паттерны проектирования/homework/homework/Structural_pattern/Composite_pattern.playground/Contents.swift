// https://ru.wikipedia.org/wiki/Компоновщик_(шаблон_проектирования)
// https://en.wikipedia.org/wiki/Composite_pattern
/*
 Компоновщик — это структурный паттерн, который позволяет создавать дерево объектов и работать с ним так же, как и с единичным объектом. (Источник: https://refactoring.guru/ru/design-patterns/composite/swift/example)
 
 Компоновщик является составной частью шаблона MVC
 Пример работы паттерна можно наблюдать, когда вы работаете с view-элементами
*/

import PlaygroundSupport
import UIKit

class mainView: UIView {}

class childView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.frame.size = CGSize(width: frame.size.width/1.25, height: frame.size.height/2)
        self.center = CGPoint(x: frame.midX, y: frame.midY)
        self.layer.backgroundColor = UIColor.systemBlue.cgColor
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.frame.size = CGSize(width: frame.size.width/2.25, height: frame.size.height/3)
        self.center = CGPoint(x: frame.midX, y: frame.midY)
        self.layer.backgroundColor = UIColor.red.cgColor
        self.setTitle("Show secret", for: .normal)
        self.addTarget(self, action: #selector(self.touch), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    @objc func touch() {
        let qrView = UIImageView(image: self.qrCode(text: "https://clck.ru/PyGw6"))
        qrView.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        self.isEnabled = false
        self.addSubview(qrView)
    }
    func qrCode(text: String) -> UIImage? {
        if let f = CIFilter(name: "CIQRCodeGenerator") {
            f.setValue(text.data(using: String.Encoding.ascii), forKey: "inputMessage")
            let at = CGAffineTransform(scaleX: 5, y: 5)

            if let output = f.outputImage?.transformed(by: at) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}

class Client {
    func build() {
        let main = mainView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        PlaygroundPage.current.liveView = main
        let child = childView(frame: main.frame)
        main.addSubview(child)
        child.addSubview(button(frame: child.bounds))
    }
}

let client = Client()
_ = client.build()

// Skillbox
// Скиллбокс
