//
//  HomeViewModel.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

protocol HomeViewModelType {
    var coordinator: HomeCoordinatorDelegate! { get set }
    var controller: HomeControllerInterface! { get set }
    var service: PasswordServiceType! { get set }
    func addPassword()
    func removePassword(_ password: Password)
    func fetchPasswords()
    func presentOptionsAlertController(forPassword password: Password)
}

class HomeViewModel: HomeViewModelType {
    var coordinator: HomeCoordinatorDelegate!
    var controller: HomeControllerInterface!
    var service: PasswordServiceType!
    
    init(service: PasswordServiceType, coordinator: HomeCoordinatorDelegate) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func addPassword() {
        self.coordinator.presentAddPassword()
    }
    
    func removePassword(_ password: Password) {
        self.service.remove(password: password)
        self.fetchPasswords()
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
    
    func presentOptionsAlertController(forPassword password: Password) {
        let alertController = UIAlertController(title: "Escolha uma opção", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Remover", style: .destructive, handler: { (_) in
            self.removePassword(password)
        }))
        alertController.addAction(UIAlertAction(title: "Editar", style: .default, handler: { (_) in
            self.coordinator.presentPassword(password)
        }))
        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.controller.show(alertController: alertController)
    }
}
