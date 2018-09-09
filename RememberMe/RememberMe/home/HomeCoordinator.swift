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
    }
    
    func present() {
        let homeController = HomeController.instantiate() as! HomeController
        let passwordService = PasswordService()

        let homeViewModel = HomeViewModel(service: passwordService)
        homeController.homeViewModel = homeViewModel
        
        current = homeController
        self.navigationController.pushViewController(homeController, animated: true)
    }
}
