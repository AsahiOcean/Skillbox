import UIKit
import MapKit
import CoreLocation

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

class AppleViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    var POI: [Place] = []
    
    @IBOutlet weak var findMe: UIButton!
    @IBAction func findMeAction(_ sender: UIButton) {
        if mapView.showsUserLocation == false {
            print("Начинаю поиск") // looking for you
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            
            // следовать ли камере за пользователем на карте
            mapView.userTrackingMode = .follow
            mapView.showsUserLocation = true
            
            findMe.backgroundColor = .systemBlue
        } else {
            let alert = UIAlertController(title: "Вернуться обратно?", message: "Return to starting point?", preferredStyle: .alert)
            
            alert.addAction(.init(title: "Да (Yes)", style: .default, handler: { action in
                locationManager.stopUpdatingLocation()
                locationManager.stopUpdatingHeading()
                mapView.userTrackingMode = .none
                mapView.showsUserLocation = false
                
                print("Поиск остановлен") // stop get location
                findMe.backgroundColor = .lightGray
                
                mapView.centerToLocation(CLLocation(latitude: POI.center()?.latitude ?? 0, longitude: POI.center()?.longitude ?? 0), regionRadius: 2000)
            }))
            alert.addAction(.init(title: "Нет (No)", style: .cancel, handler: nil))
            
            present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData()
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = false
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsCompass = true
        mapView.showsScale = true
        
        //MARK: Поможет вывести аннотацию с названием и описанием
        mapView.addAnnotations(POI)
        mapView.register(Place.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        // Compiler error: Invalid library file
        // mapView.showsTraffic = true
        
        if let center = POI.center() {
            mapView.centerToLocation(.init(latitude: center.latitude, longitude: center.longitude), regionRadius: 2000)
        }
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("POI isEmpty?: \(POI.isEmpty)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.removeAnnotations(POI)
    }
    
    // https://www.raywenderlich.com/7738344-mapkit-tutorial-getting-started#toc-anchor-015
    private func loadInitialData() {
        print("loadInitialData")
        guard
            let fileName = Bundle.main.url(forResource: "PublicArt", withExtension: "geojson"),
            let artworkData = try? Data(contentsOf: fileName)
        else {
            return
        }
        do {
            let features = try MKGeoJSONDecoder()
                .decode(artworkData)
                .compactMap { $0 as? MKGeoJSONFeature }
            let validWorks = features.compactMap(Place.init)
            POI.append(contentsOf: validWorks)
        } catch {
            print("Unexpected error: \(error).")
        }
    }
}
// https://www.raywenderlich.com/7738344-mapkit-tutorial-getting-started
private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
extension AppleViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("lat: \(userLocation.coordinate.latitude), lng: \(userLocation.coordinate.longitude)")
        
        // Костыль, чтобы камера не стояла на месте при повторном поиске геолокации пользователя
        // mapView.camera.centerCoordinate = userLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //        if let location = locations.last {
        //             print("New location is \(location)") // ок
        //        }
    }
    /*
     https://www.raywenderlich.com/7738344-mapkit-tutorial-getting-started#toc-anchor-009
     */
    // метод mapView будет вызван для каждой аннотации, которая добавляется на карту
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // проверяем является ли аннотация объектом Place
        // иначе возвращаем nil, тем самым аннотация примет вид по умолчанию
        
        guard let annotation = annotation as? Place else { return nil }
        
        // идентификатор может быть уникальным, например для использования разных стилей аннотаций для одного и того же объекта
        
        let identifier = "annotation"
        var view: MKMarkerAnnotationView
        // переиспользование аннотации, аналог Reusable у ячеек таблиц
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            //MARK: создание аннотации и вывод информации внутри нее
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            
            let size = CGSize(width: 48, height: 48)
            let mapsButton = UIButton(frame: .init(origin: .zero, size: size))
            
            //MARK: изображение в фон кнопки внутри аннотации
            mapsButton.setBackgroundImage(annotation.image, for: .normal)
            
            view.rightCalloutAccessoryView = mapsButton
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let title = view.annotation?.title as? String else { return }
        guard let subtitle = view.annotation?.subtitle as? String else { return }
        print("▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼")
        print("> ПОЛЬЗОВАТЕЛЬ НАЖАЛ НА ОБЪЕКТ: <")
        print(title)
        print(subtitle)
        print("▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let title = view.annotation?.title as? String else { return }
        guard let subtitle = view.annotation?.subtitle as? String else { return }
        
        if control == view.rightCalloutAccessoryView {
            print("⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ")
            print("[ Нажата кнопка внутри аннотации ]")
            print(title)
            print(subtitle)
            print("⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ⟡ ")
        }
    }
}

/*
 https://developer.apple.com/documentation/bundleresources/information_property_list/NSLocationAlwaysAndWhenInUseUsageDescription
 <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
 <string>Доступ к геоданным сделает пользование приложением еще более удобным и быстрым!</string>
 
 https://developer.apple.com/documentation/bundleresources/information_property_list/NSLocationAlwaysUsageDescription
 // Указывает причину доступа к информации о расположении пользователя
 <key>NSLocationAlwaysUsageDescription</key>
 <string>Доступ к геоданным сделает пользование приложением еще более удобным и быстрым!</string>
 
 https://developer.apple.com/documentation/bundleresources/information_property_list/NSLocationWhenInUseUsageDescription
 // «При использовании программы»
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>Доступ к геоданным сделает пользование приложением еще более удобным и быстрым!</string>
 
 // Доступ к шагомеру
 <key>NSMotionUsageDescription</key>
 <string>Доступ приложения к шагомеру поможет Вам сделать еще больше шагов!</string>
 */
