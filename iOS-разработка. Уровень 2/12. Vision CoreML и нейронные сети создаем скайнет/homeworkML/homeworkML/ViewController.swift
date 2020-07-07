import UIKit
import CoreML
import Vision
// Skillbox
// VisionBasic
/*
Создайте ML модель, которая умеет различать собак, кошек, мышей и деревья

Создайте свой Skynet в режиме реального времени, у которого будет показываться камера и кнопка “Стрелять”. По нажатию на нее вылетает ракета, которая летит к ближайшему найденному лицу. При движении лица ракета автоматически изменяет траекторию
 
В ML-модели: 1000 кошек, 1000 собак, 50 мышей, 50 деревьев + поровоты картинок
 
//MARK: Внимание!
Во время анализа изображений возможно появление странных звуков изнутри компьютера, похожих на звук затвора фотоаппарата. Вероятно, это связано c троттлингом CPU/GPU при выполнении ресурсоемких задач.
*/

class ViewController: UIViewController {
    
    @IBOutlet weak var catsImages: UIImageView!
    @IBOutlet weak var catsDetection: UILabel!
    
    @IBOutlet weak var dogsImages: UIImageView!
    @IBOutlet weak var dogsDetection: UILabel!
    
    @IBOutlet weak var miceImages: UIImageView!
    @IBOutlet weak var miceDetection: UILabel!
    
    @IBOutlet weak var treeImages: UIImageView!
    @IBOutlet weak var treeDetection: UILabel!
    
    let delay: TimeInterval = 5.0
    private let visionQueue = DispatchQueue(label: "com.example.apple-samplecode.serialVisionQueue")
    
    func test(imageView: UIImageView, outputInfo: UILabel, detect: String) {
        var classificationRequest: VNCoreMLRequest = {
            do {
                let model = try VNCoreMLModel(for: MyImageClassifier().model)
                
                let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                    self?.processClassifications(for: request, error: error, outputInfo: outputInfo, identifier: detect)
                })
                // Конструкция для определения режима масштабирования в UIImageView и передачи его в запрос
                // В сториборде у UIImageView специально установлены разные режимы contentMode
                let value: Int = imageView.contentMode.rawValue
                switch value {
                case 0:
                    //print("case: \(value)")
                    request.imageCropAndScaleOption = .centerCrop
                case 1:
                    //print("case: \(value)")
                    request.imageCropAndScaleOption = .scaleFit
                case 2:
                    //print("case: \(value)")
                    request.imageCropAndScaleOption = .scaleFill
                default:
                    //print("case default")
                    request.imageCropAndScaleOption = .centerCrop
                }
                return request
            } catch {
                fatalError("Ошибка загрузки ML модели: \(error)")
            }
        }()
        
        func updateClassifications(_ image: UIImage) {
            outputInfo.text = "Анализирую..."
            
            /// этот метод использует расширения (см: Extensions.swift)
            let orientation = CGImagePropertyOrientation(image.imageOrientation)
            
            guard let ciImage = CIImage(image: image) else { return print("Невозможно создать \(CIImage.self) из \(image).")}
            
            visionQueue.async {
                let handler = VNImageRequestHandler(ciImage: ciImage,
                orientation: orientation)
                do {
                    try handler.perform([classificationRequest])
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        updateClassifications(imageView.image!)
    }
    
    func processClassifications(for request: VNRequest, error: Error?, outputInfo: UILabel?, identifier: String) {
        
        guard let results = request.results else {
            print("Ошибка анализа: \(error!.localizedDescription)")
            return
        }
        
        if results.isEmpty {
            print("results.isEmpty")
        } else if let observations = request.results as? [VNClassificationObservation] {

            /// вывод трех лучших результатов совпадений
            let topResults = observations.prefix(3)
            
            let descriptions = topResults.map { results in
                return String(format: "%@: %.0f", results.confidence * 100, results.identifier) + "%"
            }
                        
            //MARK: Внимание!
            // Модель работает неидеально. Иногда загружаются картинки совершенно не по запросу - это могут быть книги, дома, люди, еда и еще какая-нибудь хрень, но модель все-равно будет коррелировать изображение со своими данными
            // метод ниже сравнивает название лучшего результата с заранее заданным словом и по моему мнению такой способ ужасен (сделайте что-нибудь получше)
            
            /// результат с максимальной уверенностью
            let best = observations.first
            let bestPrefix = best!.identifier.hasPrefix(identifier)
            let bestConfidence = best!.confidence
            
            DispatchQueue.main.async {
            if bestPrefix && bestConfidence >= 0.9 {
                outputInfo?.backgroundColor = .systemGreen
            } else if bestPrefix && bestConfidence >= 0.6 {
                outputInfo?.backgroundColor = .systemYellow
            } else {
                outputInfo?.backgroundColor = .systemRed
            }
            outputInfo?.text = "Результат:\n" + descriptions.joined(separator: "\n")
            }
        }
    }
    
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let alert = UIAlertController(title: "Внимание!", message: "После нажатия \"ОК\" каждые 5 секунд начнется загрузка и классификация изображений", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { action in
            
            Timer.scheduledTimer(timeInterval: self.delay, target: self, selector: #selector(self.catTimer), userInfo: nil, repeats: true)

            Timer.scheduledTimer(timeInterval: self.delay, target: self, selector: #selector(self.dogsTimer), userInfo: nil, repeats: true)

            Timer.scheduledTimer(timeInterval: self.delay, target: self, selector: #selector(self.micesTimer), userInfo: nil, repeats: true)

            Timer.scheduledTimer(timeInterval: self.delay, target: self, selector: #selector(self.treesTimer), userInfo: nil, repeats: true)
            
            var sec = 5
            while sec > 0 {
                print("Старт через \(sec) сек")
                sec -= 1
                sleep(1)
            }
        }))
        
        self.present(alert, animated: true)
    }
      
//MARK: -- CATS
    @objc func catTimer() {
    // картинки с котами
        let n = Int.random(in: 400...500)
        let url = URL(string: "https://placekitten.com/\(n)/\(n)")!
            
        if let data = try? Data(contentsOf: url) {
            let img = UIImage(data: data)
            DispatchQueue.main.async {
            self.catsImages.image = img
            self.test(imageView: self.catsImages, outputInfo: self.catsDetection, detect: "cat")
            }
        }
    }
    
//MARK: -- DOGS
    @objc func dogsTimer() {
    // картинки с собаками
        guard let test = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }
        let task = URLSession.shared.dataTask(with: test) { (data, response, error) in
        guard let response = data, error == nil else {
                print(error?.localizedDescription ?? "ошибка response"); return }
            do {
                let json = try JSONSerialization.jsonObject(with: response, options: []); //print(json)
                
                guard let jsonArr = json as? [String:String] else { return }; //print(jsonArr)
                        
                guard let message = jsonArr["message"] else { return }
                // print(message)
                
                let url = URL(string: message)!
                
                if let data = try? Data(contentsOf: url) {
                    let img = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.dogsImages.image = img
                        self.test(imageView: self.dogsImages, outputInfo: self.dogsDetection, detect: "dog")
                    }
                }

            } catch let parsingError { print("Error", parsingError) }
        }
        task.resume()
    }
    
//MARK: -- MICES
    @objc func micesTimer() {
    // возможные картинки с мышами
        guard let test = URL(string: "https://pixabay.com/api/?key=17295923-36a07c48c0a45e440093964e7&q=mices&image_type=photo&pretty=true&page=\(Int.random(in: 1...10))") else { return }

        let task = URLSession.shared.dataTask(with: test) { (data, response, error) in
        guard let response = data, error == nil else {
                print(error?.localizedDescription ?? "ошибка response"); return }
            do {
                let json = try JSONSerialization.jsonObject(with: response, options: []); //print(json)
                
                guard let jsonDict = json as? NSDictionary else { return }; // print(jsonDict["hits"])
                
                guard let URLs = jsonDict["hits"] as? [[String:Any]] else { return }
                
                var links: [String] = []
                
                for url in URLs {
                    links.append(url["webformatURL"] as! String)
                }
                
                let url = URL(string: links.randomElement()!)!
                
                if let data = try? Data(contentsOf: url) {
                    let img = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.miceImages.image = img
                        self.test(imageView: self.miceImages, outputInfo: self.miceDetection, detect: "mice")
                    }
                }
            
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
//MARK: -- TREES
    @objc func treesTimer() {
    // возможные картинки с деревьями
        guard let test = URL(string: "https://pixabay.com/api/?key=17298086-cd25ee4c9ebe1644d81ca317e&q=trees&image_type=photo&pretty=true&page=\(Int.random(in: 1...10))") else { return }
        
        let task = URLSession.shared.dataTask(with: test) { (data, response, error) in
        guard let response = data, error == nil else {
                print(error?.localizedDescription ?? "ошибка response"); return }
            do {
                let json = try JSONSerialization.jsonObject(with: response, options: []); //print(json)
                
                guard let jsonDict = json as? NSDictionary else { return }; // print(jsonDict["hits"])
                
                guard let URLs = jsonDict["hits"] as? [[String:Any]] else { return }
                
                var links: [String] = []
                
                for url in URLs {
                    links.append(url["webformatURL"] as! String)
                }
                
                let url = URL(string: links.randomElement()!)!
                
                if let data = try? Data(contentsOf: url) {
                    let img = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.treeImages.image = img
                        self.test(imageView: self.treeImages, outputInfo: self.treeDetection, detect: "tree")
                    }
                }
            } catch let parsingError { print("Error", parsingError) }
        }
        task.resume()
    }
}
/*
    Архив изображений от Google
    https://storage.googleapis.com/openimages/web/download.html
 
 
    Генерация с помощью ИИ:
    Коты
    https://thiscatdoesnotexist.com/image
 
    Лица
    https://thispersondoesnotexist.com/
 
    Лошади
    https://thishorsedoesnotexist.com/
 
    Рисунки
    https://thisartworkdoesnotexist.com/
*/
