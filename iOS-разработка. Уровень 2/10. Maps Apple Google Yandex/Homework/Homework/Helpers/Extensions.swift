import Foundation
import UIKit
import YandexMapKit
// Skillbox
// Скиллбокс

extension UIImage {
    func scaled(with scale: CGFloat) -> UIImage? {
        let size = CGSize(width: floor(self.size.width * scale), height: floor(self.size.height * scale))
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

struct AssociatedKeys {
    static var Title: UInt8 = 0
    static var Snippet: UInt8 = 0
}
extension YMKMapObject {
    var title: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.Title) as? String
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.Title, newValue as String?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    var snippet: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.Snippet) as? String
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.Snippet, newValue as String?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
//MARK: для центровки по массиву координат
// вместо Place может быть Annotation
extension Array where Element == Place {
    // region == getRegion
    func region() -> YMKBoundingBox? {
        guard self.count > 1 else { return nil }
        
        let longArray = self.map { $0.coordinate.longitude }
        let latArray = self.map { $0.coordinate.latitude }
        
        let minLong = longArray.min()!
        let maxLong = longArray.max()!
        
        let minLat =  latArray.min()!
        let maxLat =  latArray.max()!
        
        let southWest = YMKPoint(latitude: minLat, longitude: minLong)
        let northEast = YMKPoint(latitude: maxLat, longitude: maxLong)
        
        return YMKBoundingBox(southWest: southWest, northEast: northEast)
    }
    
    // center == getCenterPoint
    func center() -> YMKPoint? {
        guard self.count >= 1 else { return nil }
        
        let longArray = self.map { $0.coordinate.longitude }
        let latArray = self.map { $0.coordinate.latitude }
        
        let minLong = longArray.min()!
        let maxLong = longArray.max()!
        
        let minLat =  latArray.min()!
        let maxLat =  latArray.max()!
        
        return YMKPoint(latitude: (minLat + maxLat) / 2, longitude: (minLong + maxLong) / 2)
    }
}
extension String {
    var hex: Int? {
        return Int(self, radix: 16)
    }
}
extension UIColor {
    convenience init?(hex: String?) {
        guard let rgba = hex, let val = Int(rgba.replacingOccurrences(of: "#", with: ""), radix: 16) else {
            return nil
        }
        self.init(red: CGFloat((val >> 24) & 0xff) / 255.0, green: CGFloat((val >> 16) & 0xff) / 255.0, blue: CGFloat((val >> 8) & 0xff) / 255.0, alpha: CGFloat(val & 0xff) / 255.0)
    }
    convenience init?(hexRGB: String?) {
        guard let rgb = hexRGB else {
            return nil
        }
        self.init(named: rgb + "ff")
    }
}
