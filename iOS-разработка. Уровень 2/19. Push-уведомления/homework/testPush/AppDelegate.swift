import UIKit
import FirebaseCore
import FirebaseMessaging
import FirebaseInstanceID
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    let gcmMessageIDKey = "gcm.message_id"
    let popupText = "popupText"
    let popupButton = "popupButton"
    
//MARK: -- didFinishLaunchingWithOptions
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    //MARK: -- Check GoogleService-Info.plist
    let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
    guard let config = FirebaseOptions(contentsOfFile: path!)
        else {
        fatalError("Can't find –> GoogleService-Info.plist")
    }
    FirebaseApp.configure(options: config)
    
    //MARK: получаем токен напрямую
    InstanceID.instanceID().instanceID { (result, error) in
        guard (application.windows.first!.rootViewController as? ViewController) != nil else { return }
        if let error = error {
            print("\n= = = = = = Error fetching remote instance ID: = = = = = =")
            print("\(error.localizedDescription)")
            print("= = = = = = = = = = = = = = = = = = = = = = = =\n")
        } else if let result = result {
            print("\n= = = = = = Remote InstanceID token: = = = = = =")
            print("\(result.token)")
            print("= = = = = = = = = = = = = = = = = = = = = = = = =\n")

            guard let vc = application.windows.first!.rootViewController as? ViewController else { return }
            vc.statusToken.text = "токен получен"
            vc.statusToken.textColor = UIColor.systemGreen
            
            vc.tokenLabel.text = result.token
            vc.tokenLabel.font = .systemFont(ofSize: 12)
        }
    }
    
    Messaging.messaging().shouldEstablishDirectChannel = true
    Messaging.messaging().delegate = self
    listenForDirectChannelStateChanges()
    
    //MARK: UNUserNotificationCenter request authorization
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler:{ success, error in
            guard error == nil else {
                fatalError("requestAuthorization error \(error!.localizedDescription)")
            }
        })
    } else {
        let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
    }
    application.registerForRemoteNotifications()
    
    return true
  }

    //MARK: -- Receive remote notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        guard let vc = application.windows.first!.rootViewController as? ViewController else { return }

        if let message_id = userInfo[self.gcmMessageIDKey] {
            print("\n Message ID: \(message_id)")
            guard let result = message_id as? String else { return }
                
            // MARK: Physical device successfully receives "gcm.message_id"
            vc.messageID_label.layer.backgroundColor = UIColor.systemGreen.cgColor
            vc.messageID.layer.backgroundColor = UIColor.systemGreen.cgColor
            vc.messageID.text = result
        }

        if let popupText = userInfo[popupText] {
            guard let result = popupText as? String else { return }
            vc.popupText_label.layer.backgroundColor = UIColor.systemGreen.cgColor
            vc.popupText.layer.backgroundColor = UIColor.systemGreen.cgColor
            vc.popupText.text = result
        }
        
        if let popupButton = userInfo[popupButton] {
            guard let result = popupButton as? String else { return }
            vc.popupButton_label.layer.backgroundColor = UIColor.systemGreen.cgColor
            vc.popupButton.layer.backgroundColor = UIColor.systemGreen.cgColor
            vc.popupButton.text = result
        }

        if let popupText = userInfo[popupText] as? String,
            let popupButton = userInfo[popupButton] as? String {
            
            //MARK: На физическом устройстве алерт открывается!
            // Ключи 'popupText' и 'popupButton' нужно указать в Firebase (Дополнительные параметры -> Пользовательские данные)
            
            DispatchQueue.main.async {
                vc.alert(popupText: popupText, popupButton: popupButton)
            }
        }

        completionHandler(UIBackgroundFetchResult.newData)
    }
/*
//MARK: -- Fail To Register For Remote Notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // remote notifications are not supported in the simulator
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
*/
//MARK: -- Register For Remote Notifications With DeviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension AppDelegate: MessagingDelegate {
    //MARK: -- Receive remote message
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {

        guard let prettyPrinted = remoteMessage.appData.jsonString
            else { assertionFailure("Received direct channel message, but could not parse as JSON: \(remoteMessage.appData)")
            return
        }
        
        print("##################################################")
        print("Interpreting notification message payload:\n\(prettyPrinted)")
        print("##################################################")
        
        DispatchQueue.main.async {
        guard let vc = UIApplication.shared.windows.first!.rootViewController as? ViewController else { return }
            vc.remoteMessage.text = prettyPrinted
        }
    }
}
extension Dictionary {
    var jsonString: String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]),
            let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
        return nil
    }
}
extension AppDelegate {
    func registerForNotifications(types: UIUserNotificationType) {
        if #available(iOS 10, *) {
            let options = types.authorizationOptions()
            UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
                if success {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        } else {
            let settings = UIUserNotificationSettings(types: types, categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}
@available(iOS 10, *)
extension UIUserNotificationType {
    func authorizationOptions() -> UNAuthorizationOptions {
        var options: UNAuthorizationOptions = []
        if contains(.alert) {
            options.formUnion(.alert)
        }
        if contains(.sound) {
            options.formUnion(.sound)
        }
        if contains(.badge) {
            options.formUnion(.badge)
        }
        return options
    }
}
extension AppDelegate {
  func listenForDirectChannelStateChanges() {
    NotificationCenter.default
      .addObserver(self, selector: #selector(onMessagingDirectChannelStateChanged(_:)),
                   name: .MessagingConnectionStateChanged, object: nil)
  }

    @objc func onMessagingDirectChannelStateChanged(_ notification: Notification) {
    print("FCM Direct Channel Established: \(Messaging.messaging().isDirectChannelEstablished)")
  }
}
