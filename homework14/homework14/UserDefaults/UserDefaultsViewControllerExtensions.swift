//
//  UserDefaultsViewControllerExtensions.swift
//  homework14
//
//  Created by Serg Fedotov on 11.04.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import UIKit

extension UserDefaultsViewController {
    func transitionFlipFromTop(_ viewToAnimate: UITextField) {
        UITextField.transition(
            with: viewToAnimate,
            duration: 0.5,
            options: .transitionFlipFromTop,
            animations: nil,
            completion: nil)
    }
    func transitionFlipFromBottom(_ viewToAnimate: UITextField) {
        UITextField.transition(
            with: viewToAnimate,
            duration: 0.5,
            options: .transitionFlipFromBottom,
            animations: nil,
            completion: nil)
    }
}
