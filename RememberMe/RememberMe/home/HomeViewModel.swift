//
//  HomeViewModel.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import Foundation

protocol HomeViewModelType {
    var controller: HomeControllerInterface! { get set }
    var service: PasswordServiceType! { get set }
    func fetchPasswords()
}

class HomeViewModel: HomeViewModelType {
    var controller: HomeControllerInterface!
    var service: PasswordServiceType!
    
    init(service: PasswordServiceType) {
        self.service = service
    }
    
    func fetchPasswords() {
        self.service.fetch { passwords, error in
            if let _ = error {
                DispatchQueue.main.async {
                    self.controller.show(state: .error, withPasswords: [])
                }
            } else {
                if (passwords.isEmpty) {
                    DispatchQueue.main.async {
                        self.controller.show(state: .empty, withPasswords: [])
                    }
                } else {
                    DispatchQueue.main.async {
                        self.controller.show(state: .passwords, withPasswords: passwords)
                    }
                }
            }
        }
    }
}
