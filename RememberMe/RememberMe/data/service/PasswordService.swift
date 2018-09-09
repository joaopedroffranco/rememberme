//
//  PasswordService.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import Foundation

protocol PasswordServiceType {
    func add(name: String, content: String)
    func remove(password: Password)
    func fetch(callback: (_ passwords: [Password], _ error: String?) -> Void)
}

class PasswordService: PasswordServiceType {
    func add(name: String, content: String) {
        let passwordObject = Password.get()
        passwordObject?.name = name
        passwordObject?.content = content
        CoreDataManager.shared.saveContext()
    }
    
    func remove(password: Password) {
        Password.delete(object: password)
        CoreDataManager.shared.saveContext()
    }

    func fetch(callback: ([Password], String?) -> Void) {
        let passwords = Password.fetch()
        callback(passwords, nil)
    }
}
