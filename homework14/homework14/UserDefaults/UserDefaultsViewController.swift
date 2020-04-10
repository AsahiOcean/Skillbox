//
//  ViewController.swift
//  homework14
//
//  Created by Serg Fedotov on 11.04.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import UIKit

class UserDefaultsViewController: UIViewController {
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Surname: UITextField!
    
    @IBAction func NameEdit(_ sender: Any) {
        UserDataPersistance.sharing.NameData = Name.text
    }
    
    @IBAction func SurnameEdit(_ sender: Any) {
        UserDataPersistance.sharing.SurnameData = Surname.text
    }
    
    @IBAction func NameCleaner(_ sender: Any) {
        (Name.text, Surname.text) = (nil, nil)
        UserDataPersistance.sharing.NameData = nil
        UserDataPersistance.sharing.SurnameData = nil
        transitionFlipFromTop(Name)
        transitionFlipFromBottom(Surname)
        Name.becomeFirstResponder() // фокус на поле Name
    }
    
    @IBAction func Exit(_ sender: Any) {
        exit(0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDataPersistance.sharing.NameData != nil {
            transitionFlipFromTop(Name)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.Name.text = UserDataPersistance.sharing.NameData
            }
        }
        if UserDataPersistance.sharing.SurnameData != nil {
            transitionFlipFromTop(Surname)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.Surname.text = UserDataPersistance.sharing.SurnameData
            }
        }
    }
}
