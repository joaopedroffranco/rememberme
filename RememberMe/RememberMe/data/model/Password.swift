//
//  Password.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 13/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import Foundation

enum PasswordType {
    case other
    case social
    case email
    case card
    
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
