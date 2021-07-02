import UIKit
import GoogleMaps
import GooglePlaces
import YandexMapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GMSMapViewDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*
         https://developers.google.com/maps/documentation/ios-sdk/get-api-key?hl=ru
         */
        GMSServices.provideAPIKey("")
        GMSPlacesClient.provideAPIKey("")
        
        /*
         https://tech.yandex.ru/maps/mapkit/doc/3.x/concepts/ios/quickstart-docpage/
         */
        YMKMapKit.setApiKey("")
        
        YMKMapKit.setLocale("ru_RU") // Язык карты
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
