//
//  Password.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 13/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

enum PasswordCategory: Int {
    case social = 0
    case email = 1
    case card = 2
    case other = 3
    
    var statusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var tintColor: UIColor {
        return .white
    }
    
    var color: UIColor {
        switch self {
        case .social:
            return .appBlue
        case .email:
            return .appRed
        case .card:
            return .appGreen
        default:
            return .appBlack
        }
    }
    
    var string: String {
        switch self {
        case .social:
            return "Rede Social"
        case .email:
            return "Email"
        case .card:
            return "Cartão"
        default:
            return "Outro"
        }
    }
}

extension Password {
    var category: PasswordCategory {
        return PasswordCategory(rawValue: Int(self.type)) ?? PasswordCategory.other
    }
}
