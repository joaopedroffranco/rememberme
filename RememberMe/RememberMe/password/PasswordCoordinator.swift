//
//  PasswordCoordinator.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 09/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

protocol PasswordCoordinatorDelegate {
    func dismiss()
}

class PasswordCoordinator: Coordinador {
    var next: Coordinador!
    var navigationController: UINavigationController!
    weak var password: Password?
    
    init(navigationController: UINavigationController, password: Password? = nil) {
        self.navigationController = navigationController
        self.password = password
    }
    
    func present() {
        let passwordController = PasswordController.instantiate() as! PasswordController
        let passwordService = PasswordService()
        
        let passwordViewModel = PasswordViewModel(password: self.password, service: passwordService, coordinator: self)
        passwordController.passwordViewModel = passwordViewModel

        self.navigationController.pushViewController(passwordController, animated: true)
    }
}

extension PasswordCoordinator: PasswordCoordinatorDelegate {
    func dismiss() {
        self.navigationController.popViewController(animated: true)
    }
}
