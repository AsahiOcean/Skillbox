import Foundation

class UserDataPersistance {
    static let sharing = UserDataPersistance()
    private let (Name, Surname) = ("UserDataPersistance.Name", "UserDataPersistance.Surname")
    private let FirstRun = ("UserDataPersistance.FirstRun")
    var NameData: String? {
        set { UserDefaults.standard.set (newValue, forKey: Name) }
        get { return UserDefaults.standard.string (forKey: Name) }
    }
    var SurnameData: String? {
        set { UserDefaults.standard.set (newValue, forKey: Surname) }
        get { return UserDefaults.standard.string (forKey: Surname) }
    }
    var FirstRunData: String? {
        set { UserDefaults.standard.set (newValue, forKey: FirstRun) }
        get { return UserDefaults.standard.string (forKey: FirstRun) }
    }
}
