//
//  PasswordService.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import Foundation

protocol PasswordServiceType {
    func fetch(callback: (_ passwords: [Password], _ error: String?) -> Void)
}

class PasswordService: PasswordServiceType {
    func fetch(callback: ([Password], String?) -> Void) {
        let responseZero: [Password] = []
        let responseNoZero: [Password] = [Password(name: "bla", content: "bla")]
        
        callback(responseZero, nil)
    }
}
