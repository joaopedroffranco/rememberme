//
//  Extension.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static func instantiate(from: String = "Main") -> UIViewController {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: from, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className)
    }
}
