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
        
        // Язык карты
        YMKMapKit.setLocale("ru_RU")
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

