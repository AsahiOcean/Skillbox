import UIKit
import GoogleMaps
import GooglePlaces
import GoogleMapsUtils
// https://developers.google.com/maps/documentation/ios-sdk/start
// https://developers.google.com/maps/documentation/ios-sdk/utility/setup

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
class GoogleViewController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    private var marker = GMSMarker()
    
    //MARK: import GoogleMapsUtils !!!
    private var renderer: GMUGeometryRenderer!
    private var geoJsonParser: GMUGeoJSONParser!
    
    func colorMarker(title: String) -> UIColor {
        switch title {
        case "Макдоналдс":
            return #colorLiteral(red: 0, green: 0.3490196168, blue: 1, alpha: 1)
        case "Бургер Кинг":
            return #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        case "Дети – жертвы пороков взрослых":
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case "KFC":
            return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case "Пятёрочка":
            return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        default:
            return #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // https://developers.google.com/maps/documentation/ios-sdk
        mapView.delegate = self

        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

        mapView.settings.rotateGestures = true // поворот карты жестом
        mapView.settings.scrollGestures = true // разрешить листать карту?
        mapView.settings.zoomGestures = true // включить зум?
        
//        MARK: центрирование карты с видимостью всех маркеров
//        DispatchQueue.main.async {
//        let bounds = places.reduce(GMSCoordinateBounds()) {
//                  $0.includingCoordinate($1.coordinate)
//              }
//        self.mapView.moveCamera(.fit(bounds, withPadding: 30))
//        /self.mapView.animate(with: .fit(bounds, withPadding: 30.0))
//        }
//         - - - - - - - - - - - - - - - - - - - - - - - - - - -
        
        // geojson проверен на валидаторе https://geojsonlint.com/
        if let path = Bundle.main.path(forResource: "PublicArt", ofType: "geojson") {
            do {
                let contents = try String(contentsOfFile: path)
                print("contents.isEmpty? \(contents.isEmpty)")
                
                let url = URL(fileURLWithPath: path)
                geoJsonParser = GMUGeoJSONParser(url: url)
                geoJsonParser.parse()
                
            var bounds = GMSCoordinateBounds() // <--- для центрирования

            for feature in geoJsonParser.features {
                if let feature = feature as? GMUFeature {
                    if let properties = feature.properties {
                        if (feature.geometry as? GMUPoint) == nil { continue }
                        // - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        //MARK: UPDATE: центрирование карты на маркеры с данными из geoJsonParser
                        let point = feature.geometry as! GMUPoint
                        bounds = bounds.includingCoordinate(point.coordinate)
                        mapView.moveCamera(.fit(bounds, withPadding: 30))
                        // - - - - - - - - - - - - - - - - - - - - - - - - - - -
                            
                        if properties["title"] != nil {
                            let title = properties["title"] as? String ?? "no title"
                            // let discipline = properties["discipline"] as? String ?? "no description"
                            let stroke = properties["stroke"] as? String ?? "#52fb71"
                            let strokeWidth = properties["strokeWidth"] as? String ?? "12"
                            let fill = properties["fill"]  as? String ?? "#c71799"
                            let iconUrl = properties["iconUrl"] as! String
                                
                            let style = GMUStyle(
                                styleID: "\(title)", // идентификатор GMUStyle
                                stroke: UIColor(hex: stroke), // цвет обводки
                                fill: UIColor(hex: fill), // цвет заливки
                                width: CGFloat(Double(strokeWidth) ?? 13.0), // ширина обводки
                                scale: CGFloat(1), // делитель размера метки
                                heading: CGFloat(30.0), // угол наклона метки
                                anchor: CGPoint(x: 0, y: 0), // смещение метки
                                iconUrl: iconUrl, // заменит метку картинкой по URL
                                title: title,
                                hasFill: true,
                                hasStroke: true)
                            
                            // print(style.fillColor)
                            feature.style = style
                        }
                    }
                }
            }
            } catch {
                print("Содержимое не загружено")
            }
        } else {
            print("FILE NOT FOUND ?!")
            print("УБЕДИТЕСЬ ЧТО ЕСТЬ ГАЛОЧКА В Target Membership!")
        }
        self.renderer = GMUGeometryRenderer(map: self.mapView, geometries: self.geoJsonParser.features)
        self.renderer.render()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MARK: -- добавление маркеров простым способом
        // https://developers.google.com/maps/documentation/ios-sdk/marker
        for place in places {
            let marker = GMSMarker(position: place.coordinate)
            marker.title = place.title
            marker.snippet = place.snippet
            marker.icon = GMSMarker.markerImage(with: colorMarker(title: place.title!))
            marker.map = self.mapView
        }
        
        // MARK: -- Пример работы GMSMapStyle
        // MARK: Все норм работает, для json-а стилей можно найти какой-нибудь генератор, например https://mapstyle.withgoogle.com/ или собрать вручную (для извращенцев)
//        do {
//            if let styleURL = Bundle.main.url(forResource: "mapStyle", withExtension: "json") {
//                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
//            } else {
//                print("error111 - styleURL")
//            }
//        } catch {
//            print("FILE NOT FOUND ???! \(error)\n error112 - styleURL")
//            print("УБЕДИТЕСЬ ЧТО ЕСТЬ ГАЛОЧКА В Target Membership!")
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("GMUGeoJSONParser Count: \(geoJsonParser.features.count)")
    }
}
extension GoogleViewController: GMSMapViewDelegate {
    
    // MARK: - GMUMapViewDelegate
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let poiItem = marker.userData as? Place {
            print("Did tap marker for cluster item \(poiItem.title ?? "Без названия")")
        } else {
            // print("Did tap a normal marker")
            print(marker.title ?? "Без названия", " - ", marker.snippet ?? "Без описания")
        }
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        // действие после нажатия на аннотацию
        print("didTapInfoWindowOf: \(marker.title ?? "Без названия")")
    }
/*
https://developers.google.com/maps/documentation/ios-sdk/poi#listen_for_click_events_on_pois
*/
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        let marker = self.marker
        marker.snippet = placeID
        marker.position = location
        marker.title = name
        marker.opacity = 0;
        marker.infoWindowAnchor.y = 1
        marker.map = mapView
        mapView.selectedMarker = marker
                
        print("~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~")
        print("Название: \(name)")
        print("Подробнее:" + "\n" +  "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeID)&key=API_KEY")
        print("lat: \(location.latitude) lng: \(location.longitude)")
        print("~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~")
        
        /*
         https://maps.googleapis.com/maps/api/place/details/json?placeid=PLACE_ID&key=API_KEY
         
        При запросе вернет JSON с подробной информацией о объекте: адрес, фото, телефон, сайт, отзывы и т.п.
        Убедитесь, авторизовано ли приложение для работы с этим сервисом
        P.S. действительно работает, но только не с этим API ключом
        */
    }
}
/*
https://sites.google.com/site/gmapsdevelopment/

https://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png
https://maps.google.com/mapfiles/kml/pushpin/blue-pushpin.png
https://maps.google.com/mapfiles/kml/pushpin/grn-pushpin.png
https://maps.google.com/mapfiles/kml/pushpin/ltblu-pushpin.png
https://maps.google.com/mapfiles/kml/pushpin/pink-pushpin.png
https://maps.google.com/mapfiles/kml/pushpin/purple-pushpin.png
https://maps.google.com/mapfiles/kml/pushpin/red-pushpin.png
https://maps.google.com/mapfiles/kml/pushpin/wht-pushpin.png
*/
