//
//  HomeCoordinator.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

protocol HomeCoordinatorDelegate {
    func presentAddPassword()
    func presentPassword(_ password: Password?)
}

class HomeCoordinator: Coordinador {
    var next: Coordinador!
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func present() {
        let homeController = HomeController.instantiate() as! HomeController
        let passwordService = PasswordService()

        let homeViewModel = HomeViewModel(service: passwordService, coordinator: self)
        homeController.homeViewModel = homeViewModel
        
        self.navigationController.pushViewController(homeController, animated: true)
    }
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    func presentAddPassword() {
        let passwordCoordinator = PasswordCoordinator(navigationController: self.navigationController)
        self.next = passwordCoordinator
        passwordCoordinator.present()
    }
    
    func presentPassword(_ password: Password?) {
        let passwordCoordinator = PasswordCoordinator(navigationController: self.navigationController, password: password)
        self.next = passwordCoordinator
        passwordCoordinator.present()
    }
}
