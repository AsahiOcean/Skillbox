import UIKit
import MapKit
import YandexMapKit
// Skillbox
// Скиллбокс

// статья про связку CLLocationManager и YMKLocationManager
// https://habr.com/ru/post/479432/

// Описание ключей для info.plist
/* http://spec-zone.ru/RU/iOS/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html
 */

/*
Домашняя работа:
интегрировать в проект следующие карты: Google, Yandex, AppleMaps

для каждого типа карт, сделать следующие задания (для каждой карты на отдельном контроллере):
1) показ самой карты на весь экран
2) показ пользователя
3) показ 5 точек (POI) с достопримечательностями в вашем городе (достопримечательности на ваш выбор) с разными иконками
4) центрирование карты на эти 5 точек
5) обработку нажатия на точки: при нажатии выводить в консоль название достопримечательности, на которую нажали
*/

class YandexViewController: UIViewController {
    @IBOutlet weak var mapView: YMKMapView!
    private var annotations: [YMKPlacemarkMapObject] = []
    @IBOutlet weak var findMe: UIButton!
    @IBAction func findMeAction(_ sender: UIButton) {
        
        if toggle == false {
            print("Ищу тебя 👀") // looking for you
            let scale = UIScreen.main.scale
            userLocationLayer.setVisibleWithOn(true)
            //userLocationLayer.isAutoZoomEnabled = true
            userLocationLayer.isHeadingEnabled = true
            
            //MARK: nil - дефолтный маркер (стрелочка или метка "Я")
            userLocationLayer.setObjectListenerWith(nil)
            //MARK: self - наследует маркер из метода onObjectAdded
            //userLocationLayer.setObjectListenerWith(self)
            
            userLocationLayer.setAnchorWithAnchorNormal(CGPoint(
                x: 0.5 * mapView.frame.size.width * scale,
                y: 0.5 * mapView.frame.size.height * scale),
                // anchorCourse - положение маркера пользователя на экране
                    anchorCourse: CGPoint(
                        x: 0.5 * mapView.frame.size.width * scale,
                        y: 0.75 * mapView.frame.size.height * scale))
            
            //MARK: Запись координат передвижения камеры(!)
            //в момент нажатия кнопки findMe можно записать последние координаты камеры, чтобы вернуться обратно
            //не забудьте добавить это во viewDidLoad()
            mapView.mapWindow.map.addCameraListener(with: self)
            
            self.findMe.setTitle("STOP", for: .normal)
            self.findMe.backgroundColor = .systemRed
            self.toggle = true
        } else {
            userLocationLayer.setVisibleWithOn(false)
            mapView.mapWindow.map.removeCameraListener(with: self)
            self.toggle = false
            print("Поиск остановлен") // stop get location
            self.findMe.setTitle("Find Me", for: .normal)
            self.findMe.backgroundColor = .systemGreen
            
            let alert = UIAlertController(title: "Вернуться обратно?", message: "Return to starting point?", preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Да (Yes)", style: .default, handler: { action in
                self.mapView.mapWindow.map.move(with: YMKCameraPosition(
                        target: places.center()!,
                        zoom: self.zoom,
                        azimuth: 0,
                        tilt: 0),
                            animationType: YMKAnimation(
                                type: .smooth,
                                duration: 1),
                                cameraCallback: nil)
            }))
            alert.addAction(UIAlertAction(title: "Нет (No)", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    private var circleMapObjectTapListener: YMKMapObjectTapListener!
    lazy var userLocationLayer = YMKMapKit.sharedInstance().createUserLocationLayer(with: mapView.mapWindow)
    var toggle = false
    
    var zoom: Float = 1
    private var animationIsActive = true
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.layer.zPosition = 1
        
        //MARK: findMe button
        DispatchQueue.main.async {
            self.findMe.layer.cornerRadius = self.findMe.frame.width / 2
            self.findMe.layer.frame.size = CGSize(width: 80, height: 80)
        }
        mapView.addSubview(findMe)
        findMe.layer.zPosition = 1000

        let map = mapView.mapWindow.map
        map.isRotateGesturesEnabled = true
        map.isNightModeEnabled = false
        
        //MARK: подгон видимого региона под ширину экрана
        //вероятно в YandexMapKit есть функция которая делает тоже самое
        //в Extensions.swift лежит формула для YMKVisibleRegion
        func calcZoom(region: YMKBoundingBox!) -> Float {
            let width = Float(self.view.frame.size.width)
            let southWest = region.southWest
            let northEast = region.northEast

            var delta = Float(northEast.longitude - southWest.longitude)

            if delta < 0 {
                delta = Float(360 + northEast.longitude) - Float(southWest.longitude)
            }
            return log2(360 * width / (360 * Float(delta)))
        }
        
        self.zoom = calcZoom(region: places.region())
        
        /*
         https://tech.yandex.com/maps/mapkit/doc/3.x/concepts/ios/quickstart-docpage/
         */
        mapView.mapWindow.map.move(with: YMKCameraPosition(
                target: places.center()!,
                zoom: self.zoom,
                azimuth: 0,
                tilt: 0), // наклон камеры
                    animationType: YMKAnimation(
                        type: .smooth,
                        duration: 2),
                        cameraCallback: { _ in
                    print("ZOOM = \(self.zoom)\n")
                    print("~~~~~~~~~~~~~~~~~~~~~")
                })
        
        //MARK: - mapObjects
        let mapObjects = mapView.mapWindow.map.mapObjects
        
        for place in places {
            let placemark = mapObjects.addPlacemark(with: YMKPoint(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude))
                        
            let image = place.image?.scaled(with: 0.25) ?? UIImage(named: "marker")!
                        
            placemark.title = place.title!
            placemark.snippet = place.snippet!
            placemark.setIconWith(image)
            
        }
        //MARK: addTapListener поможет отследить нажатие на объект
        mapObjects.addTapListener(with: self)
    }
    
    func YMKAnnotation(geopoint: YMKPoint, text: String) {
        
        let annotationView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        let textView = UITextView()
        textView.text = text
        textView.sizeToFit()
        textView.center = annotationView.center
        annotationView.addSubview(textView)
        
        let viewProvider = YRTViewProvider(uiView: annotationView)
        
        let mapObjects = mapView.mapWindow.map.mapObjects
        let viewPlacemark = mapObjects.addPlacemark(
            with: geopoint,
            view: viewProvider!)
        
        viewProvider?.snapshot()
        viewPlacemark.setViewWithView(viewProvider!)
    }
}

extension YandexViewController: YMKMapObjectTapListener {
    
    // MARK: - YMKMapObjectTapListener
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        
        guard let placemark = mapObject as? YMKPlacemarkMapObject else { return false }
        
        if placemark.title != nil {
            print("\(placemark.title!)" + " (\(placemark.snippet!))")
            YMKAnnotation(geopoint: placemark.geometry, text: placemark.title!)
        }
                
        //MARK: по нажатию можно вывести аннотацию над объектом или в отдельном окне
        // в здании указано: при нажатии выводить в консоль название достопримечательности, на которую нажали
        
        //MARK: Передвижение камеры к маркеру
        //mapView.mapWindow.map.move(with: YMKCameraPosition(target: point, zoom: zoom + 2.5, azimuth: 0, tilt: 0), animationType: YMKAnimation(type: .smooth, duration: 0.5), cameraCallback: ({ _ in print(placemark.title) }))
        return true
    }
}

extension YandexViewController: YMKLocationDelegate, YMKMapCameraListener {
    func onLocationUpdated(with location: YMKLocation) {
        print("onLocationUpdated: lat: \(location.position.latitude), lng: \(location.position.longitude)")
    }

    func onLocationStatusUpdated(with status: YMKLocationStatus) {
        print("onLocationStatusUpdated: \(status)")
    }

    func onCameraPositionChanged(with map: YMKMap, cameraPosition: YMKCameraPosition, cameraUpdateSource: YMKCameraUpdateSource, finished: Bool) {
        print("lat: \(cameraPosition.target.latitude) | lng: \(cameraPosition.target.longitude)")
    }
}
