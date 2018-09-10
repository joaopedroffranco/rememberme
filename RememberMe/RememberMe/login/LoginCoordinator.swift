//
//  LoginCoordinator.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

protocol LoginCoordinatorDelegate {
    func presentHome()
}

class LoginCoordinator: Coordinador {
    var next: Coordinador!
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.configureNavigationController()
    }
    
    func configureNavigationController() {
        self.navigationController.isNavigationBarHidden = true
    }
    
    func present() {
        let loginController = LoginController.instantiate() as! LoginController

        let loginViewModel = LoginViewModel(coordinator: self)
        loginController.loginViewModel = loginViewModel

        self.navigationController.pushViewController(loginController, animated: true)
    }
}

extension LoginCoordinator: LoginCoordinatorDelegate {
    func presentHome() {
        let homeCoordinator = HomeCoordinator(navigationController: self.navigationController)
        self.next = homeCoordinator
        homeCoordinator.present()
    }
}
