import UIKit

public extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255)
       assert(green >= 0 && green <= 255)
       assert(blue >= 0 && blue <= 255)

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}


public let MiniCells: [(title: String, description:String, color: Int)] = [
    (title: "Заголовок 1", description: "Описание 1", color: 0x00b8d9),
    (title: "Заголовок 2", description: "Описание 2", color: 0x4263a6),
    (title: "Заголовок 3", description: "Описание 3", color: 0x000000),
    (title: "Заголовок 4", description: "Описание 4", color: 0x00b8d9),
    (title: "Заголовок 5", description: "Описание 5", color: 0x4263a6),
]
