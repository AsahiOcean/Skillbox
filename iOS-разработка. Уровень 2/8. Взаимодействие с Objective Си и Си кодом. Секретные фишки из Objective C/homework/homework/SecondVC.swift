import UIKit
// Skillbox
// Скиллбокс

class SecondVC: UIViewController {
    
    var hexStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        guard self.hexStr == "" else {
            print("Приняты данные: \(self.hexStr)")
            return self.view.backgroundColor = hexString(hex: hexStr)
        }
    }
    deinit { print("\(self.classForCoder) deinit -- \(Date())") }
}
func hexString(hex: String) -> UIColor {
    var cStr: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cStr.hasPrefix("#") { cStr.remove(at: cStr.startIndex) }
    
    var rgb: UInt64 = 0
    Scanner(string: cStr).scanHexInt64(&rgb)

    return UIColor(
        red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgb & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
