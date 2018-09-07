//
//  HomeCoordinator.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinador {
    var current: UIViewController!
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.configureNavigationController()
    }
    
    func configureNavigationController() {
        self.navigationController.isNavigationBarHidden = false
    }
    
    func present() {
        let homeController = HomeController.instantiate() as! HomeController
        let passwordService = PasswordService()

        let homeViewModel = HomeViewModel(service: passwordService)
        homeController.homeViewModel = homeViewModel
        
        current = homeController
        navigationController.pushViewController(homeController, animated: true)
    }
}
