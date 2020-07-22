import Foundation
import MapKit
// Skillbox
// Скиллбокс

let places: [Place] = [
    Place(title: "Макдоналдс", snippet: "ул. Манежная пл., 1, стр. 2", hex: "#e2abfa", icon: UIImage(named: "mac")!, coordinate: CLLocationCoordinate2D(latitude: 55.7554901, longitude: 37.6143095)),
    Place(title: "Бургер Кинг", snippet: "ул. Театральный пр-д, 5", hex: "#8d7229", icon: UIImage(named: "burger")!, coordinate: CLLocationCoordinate2D(latitude: 55.7601764, longitude: 37.6249793)),
    Place(title: "Дети – жертвы пороков взрослых", snippet: "ул. Болотная пл., 10", hex: "#1bdea7", icon: UIImage(named: "children")!, coordinate: CLLocationCoordinate2D(latitude: 55.7459461, longitude: 37.619407)),
    Place(title: "KFC", snippet: "ул. Пятницкая, 11/23", hex: "#dc780d", icon: UIImage(named: "kfc")!, coordinate: CLLocationCoordinate2D(latitude: 55.7439449, longitude: 37.628147)),
    Place(title: "Пятёрочка", snippet: "ул. Котельническая наб., 1/15", hex: "#bd2ab9", icon: UIImage(named: "5")!, coordinate: CLLocationCoordinate2D(latitude: 55.7456389, longitude: 37.6429273))
]

class Place: NSObject, MKAnnotation {
    var title: String?
    var snippet: String?
    var hex: String?
    var image: UIImage?
    var coordinate: CLLocationCoordinate2D
    init(title: String?, snippet: String?, hex: String? = nil, icon: UIImage, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.snippet = snippet
        self.hex = hex
        self.image = icon
        self.coordinate = coordinate
        super.init()
    }
    
    init?(feature: MKGeoJSONFeature) {
      // 1
      guard
        let point = feature.geometry.first as? MKPointAnnotation,
        // 2
        let propertiesData = feature.properties,
        let json = try? JSONSerialization.jsonObject(with: propertiesData),
        let properties = json as? [String: Any]
        else {
          return nil
      }
      
      // 3
      title = properties["title"] as? String
      snippet = properties["snippet"] as? String
      hex = properties["fill"] as? String
      image = UIImage(named: (properties["image"] as? String)!)
      coordinate = point.coordinate
      super.init()
    }
}
/*
func zoom(map: YMKMapView) -> Float {
    let width = Float(self.view.frame.size.width)
    let visibleRegion = map.mapWindow.map.visibleRegion
    // bottomLeft == southWest
    let bottomLeft = visibleRegion.bottomLeft
    // topRight == northEast
    let topRight = visibleRegion.topRight

    var longDelta = topRight.longitude - bottomLeft.longitude

    if longDelta < 0 {
        longDelta = Double(360 + topRight.longitude) - bottomLeft.longitude
    }
    return log2(360 * width / (256 * Float(longDelta)))
}
*/
