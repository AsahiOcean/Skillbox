import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Map.delegate =  self
        
        let start = CLLocationCoordinate2D(latitude: 40.759011, longitude: -73.984472)
        let finish = CLLocationCoordinate2D(latitude: 40.748441, longitude: -73.985564)
        
        let sourcePlacemark = MKPlacemark(coordinate: start, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: finish, addressDictionary: nil)
        
        // названия меток
        let startName = MKPointAnnotation()
        startName.title = "Times Square"
        if let location = sourcePlacemark.location {
            startName.coordinate = location.coordinate
        }
        
        let finishName = MKPointAnnotation()
        finishName.title = "Empire State Building"
        if let location = destinationPlacemark.location {
            finishName.coordinate = location.coordinate
        }
        self.Map.showAnnotations([startName,finishName], animated: true)
    }
}

func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    if overlay.isKind(of: MKPolyline.self){
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.fillColor = UIColor.blue
        polylineRenderer.strokeColor = UIColor.blue
        polylineRenderer.lineWidth = 2
        
        return polylineRenderer
    }
    return MKOverlayRenderer(overlay: overlay)
}
