// https://ru.wikipedia.org/wiki/Фасад_(шаблон_проектирования)
// https://en.wikipedia.org/wiki/Facade_pattern
/*
 Фасад — это структурный паттерн, который предоставляет простой (но урезанный) интерфейс к сложной системе объектов, библиотеке или фреймворку. Кроме того, что Фасад позволяет снизить общую сложность программы, он также помогает вынести код, зависимый от внешней системы в единственное место. (Источник: https://refactoring.guru/ru/design-patterns/facade/swift/example)

 Фасад позволяет скрыть(читай упростить) сложную систему (например: библиотеку или фреймворк) за более простым интерфейсом, который необходим для решения конкретной задачи.
*/

import PlaygroundSupport
import UIKit

class Facade: UIView {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.frame.size = CGSize(width: frame.width/2, height: frame.height/2)
        
        self.imageView.layer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height/2)
        self.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func flickrImageURL(photoID: String, farm: Int, server: String, secret: String) -> URL? {
      if let url =  URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_m.jpg") {
        return url
      }
      return nil
    }
    
    func flickrSearchURL(text: String) {
        print("«Оператор»: получен запрос на изображение: \(text)")
        URLSession.shared.dataTask(with: URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=ca370d51a054836007519a00ff4ce59e&text=\(text)&sort=relevance&format=json&nojsoncallback=1")!) { (data,_,_) in
            guard let jsonData = data else {
                print("error: json is empty")
                return
            }
            print("«Хранилище»: у нас есть такие изображения!")
            guard let jsonObj = try? JSONSerialization.jsonObject(with: jsonData, options: []) else { return }
            guard let json = jsonObj as? [String:Any] else { return }
            guard let photos = json["photos"] as? [String:Any] else { return }
            guard let arrPhotos = photos["photo"] as? [Any] else { return }
            guard arrPhotos.isEmpty == false else {
                print("Photos is empty")
                return }
            guard let firstPhoto = arrPhotos.first as? [String:Any] else { return }
            print("«Упаковщик»: собираю данные для отправки изображения...")
            
            let photoID = firstPhoto["id"] as! String
            let farm = firstPhoto["farm"] as! Int
            let server = firstPhoto["server"] as! String
            let secret = firstPhoto["secret"] as! String
                        
            let finalURL = self.flickrImageURL(photoID: photoID, farm: farm, server: server, secret: secret)
            
            URLSession.shared.dataTask(with: finalURL!, completionHandler: { (data, _, _) in
                DispatchQueue.main.async {
                    print("«Курьер»: выводим изображение!")
                    self.imageView.image = UIImage(data: data!)
                }
            }).resume()
        }.resume()
    }
}

class Client {
    func request(showMe: String) {
        print("«Клиент»: хочу посмотреть на: \(showMe)")
        let fac = Facade(frame: UIScreen.main.bounds)
        fac.flickrSearchURL(text: showMe)
        PlaygroundPage.current.liveView = fac
    }
}

let client = Client()
client.request(showMe: "Cat")

// Skillbox
// Скиллбокс
