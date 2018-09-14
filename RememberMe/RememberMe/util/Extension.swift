//
//  Extension.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    static func instantiate(from: String = "Main") -> UIViewController {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: from, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className)
    }
}

extension UIView {
    static func instantiate() -> UIView {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        return UINib(nibName: className, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    static var identifier: String {
        let fullName = NSStringFromClass(self)
        return fullName.components(separatedBy: ".")[1]
    }
    
    func round() {
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
    func shadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
    }
}

extension Int {
    var color: UIColor {
        return UIColor(red: CGFloat((self >> 16) & 0xFF)/255, green: CGFloat((self >> 8) & 0xFF)/255, blue: CGFloat(self & 0xFF)/255, alpha: 1.0)
    }
}

extension UIColor {
    static var appBlue: UIColor {
        return 0x235789.color
    }
    
    static var appRed: UIColor {
        return 0xC33C54.color
    }
    
    static var appBlack: UIColor {
        return 0x30343F.color
    }
    
    static var appGreen: UIColor {
        return 0x37392E.color
    }
}
