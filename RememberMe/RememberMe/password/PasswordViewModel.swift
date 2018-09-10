//
//  PasswordViewModel.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 09/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

protocol PasswordViewModelType {
    var coordinator: PasswordCoordinatorDelegate! { get set }
    var controller: PasswordControllerInterface! { get set }
    var service: PasswordServiceType! { get set }
    var password: Password? { get set }
    func done()
}

class PasswordViewModel: PasswordViewModelType {
    var coordinator: PasswordCoordinatorDelegate!
    var controller: PasswordControllerInterface!
    var service: PasswordServiceType!
    var password: Password?
    
    init(password: Password?, service: PasswordServiceType, coordinator: PasswordCoordinatorDelegate) {
        self.password = password
        self.coordinator = coordinator
        self.service = service
    }
    
    func done() {
        let passwordInfo = self.controller.getPasswordInfo()
        if let name = passwordInfo.name, let content = passwordInfo.content, name != "" && content != "" {
            if let _ = self.password {
                self.password?.name = name
                self.password?.content = content
            } else {
                self.service.add(name: name, content: content)
            }
            
            CoreDataManager.shared.saveContext()
        }
        
        self.coordinator.dismiss()
    }
}
