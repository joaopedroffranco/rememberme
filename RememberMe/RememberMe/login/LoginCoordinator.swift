//
//  LoginCoordinator.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinador {
    var current: UIViewController!
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func present() {
        let loginController = LoginController.instantiate()
        navigationController.pushViewController(loginController, animated: true)
    }
}
