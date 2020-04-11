//
//  UserDataPersistance.swift
//  homework14
//
//  Created by Serg Fedotov on 11.04.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

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
