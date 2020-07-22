import UIKit
import Vision
/*
Создайте ML модель, которая умеет различать собак, кошек, мышей и деревья

Создайте свой Skynet в режиме реального времени, у которого будет показываться камера и кнопка “Стрелять”. По нажатию на нее вылетает ракета, которая летит к ближайшему найденному лицу. При движении лица ракета автоматически изменяет траекторию
*/
class SkynetViewController2: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let allegedFace = UIView()
    
    func loadImage1() {
        let url = URL(string: "https://source.unsplash.com/random?faces")
        if let data = try? Data(contentsOf: url!) {
            let img = UIImage(data: data)
            self.imageView.image = img
            self.detectFaceImage()
        }
    }
    
    func detectFaceImage() {
        guard let image = imageView.image else { return }
        self.allegedFace.removeFromSuperview()
                
        let request = VNDetectFaceRectanglesRequest { request, error in
            if let fail = error {
                print("Ошибка VNDetectFaceRectanglesRequest:", fail)
                return
            }
            
            if request.results?.count == 0 {
                print("No faces")
            } else {
                print("face count: \(request.results!.count)")
                
                request.results?.forEach({ result in
                    
                    DispatchQueue.main.async {
                        guard let face = result as? VNFaceObservation else { return }
                                            
                        // CGRect allegedFace
                        let x = face.boundingBox.origin.x * self.imageView.frame.width
                        let width = face.boundingBox.size.width * self.imageView.frame.width
                        let height = face.boundingBox.size.height * self.imageView.frame.height
                        let y = self.imageView.frame.maxY - (face.boundingBox.origin.y * self.imageView.frame.height) - height
                        let cgRect = CGRect(x: x, y: y, width: width, height: height)
                        
                        // Выделение области предполагаемого лица
                        self.allegedFace.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 0.5040400257)
                        self.allegedFace.frame = cgRect
                        self.view.addSubview(self.allegedFace)
                        
                        let banger = UIImageView(image: UIImage(named: "unnamed"))
                        banger.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.maxY)
                        self.view.addSubview(banger)
                        
                        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                            banger.layer.position = cgRect.center
                        }) { _ in
                            banger.removeFromSuperview()
                        }
                    }
                })
            }
        }
        
        guard let cgImage = image.cgImage else { return }
        
        DispatchQueue.global().async {
            let handler = VNImageRequestHandler(cgImage: cgImage)
            
            do {
                try handler.perform([request])
            }
            catch let error {
                print("Ошибка VNImageRequestHandler:", error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadImage1()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.test1), userInfo: nil, repeats: true)
    }
    
    @objc func test1() { self.loadImage1() }

}
extension CGRect {
    var center: CGPoint { return CGPoint(x: midX, y: midY) }
}
// https://source.unsplash.com/random?faces
// https://thispersondoesnotexist.com/image
// Skillbox
// Скиллбокс
// VisionBasic
