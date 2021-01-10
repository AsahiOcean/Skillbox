import UIKit

/*
 загрузка изображения в фоновом потоке и показ его на экране
 */

func loadimage() -> UIImage {
    let url = URL(string: "https://i.picsum.photos/id/\(Int.random(in: 0...100))/500/500.jpg")!
    if url.dataRepresentation.count > 0 {
        print(url)
        return UIImage(data: try! Data(contentsOf: url))!
    } else {
        return UIImage(named: "kermit")!
    }
}

class BackgroundDownload: UIViewController {
    @IBOutlet weak var Image: UIImageView!
    
    var img = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: viewDidLoad == Main queue
        // переключение времязатратных (в данном случае загрузка изображения) заданий с Main queue на другой поток всегда АСИНХРОННО
        DispatchQueue.global(qos: .utility).async {
            self.img = loadimage()
            // После окончания загрузки возвращаемся на Main queue для обновления UIImageView
            DispatchQueue.main.async {
                self.Image.image = self.img
            }
        }
    }
}
