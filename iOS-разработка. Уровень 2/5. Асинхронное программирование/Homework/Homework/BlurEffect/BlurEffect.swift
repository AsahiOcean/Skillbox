import UIKit

class BlurEffect: UIViewController {
    @IBOutlet weak var Image: UIImageView!
    
    var img = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: viewDidLoad == Main queue
        // переключение времязатратных (в данном случае загрузка изображения) заданий с Main queue на другой поток всегда АСИНХРОННО
        DispatchQueue.global(qos: .utility).async {
            self.img = loadimage()++
            // После окончания загрузки возвращаемся на Main queue для обновления UIImageView
            DispatchQueue.main.async {
                if self.img.cgImage?.bitmapInfo != nil { // check blur
                    self.Image.image = self.img
                } else {
                    self.Image.image = UIImage(named: "kermit")!++
                }
            }
        }
    }
}

postfix operator ++
@discardableResult postfix func ++(_ Img: UIImage) -> UIImage {
    /*
     https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/
     */
    let fltr = CIFilter(name: "CIGaussianBlur")
    fltr?.setValue(CIImage(cgImage: Img.cgImage!), forKey: "inputImage")
    fltr?.setValue(3, forKey: "inputRadius") // Default setValue: 10
    // CGSize -> CGRect
    let frame = CGRect(origin: Img.accessibilityActivationPoint, size: Img.size)
    // inputImage -> MAGIC -> outputImage
    let out: CIImage = fltr?.value(forKey: "outputImage") as! CIImage
    let kit: CGImage = CIContext().createCGImage(out, from: frame)!
    let result: UIImage = UIImage(cgImage: kit)
    return result
}
