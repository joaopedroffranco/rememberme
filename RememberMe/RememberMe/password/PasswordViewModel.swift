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
    func didChangeSelectedControl(index: Int)
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
        if let name = self.controller.name, let content = self.controller.content, name != "" && content != "" {
            if let _ = self.password {
                self.password?.name = name
                self.password?.content = content
                self.password?.desc = self.controller.desc
                self.password?.type = Int16(self.controller.category)
            } else {
                self.service.add(name: name, content: content, desc: self.controller.desc, type: Int16(self.controller.category))
            }
            
            CoreDataManager.shared.saveContext()
        }
        
        self.coordinator.dismiss()
    }
    
    func didChangeSelectedControl(index: Int) {
        self.controller.updateView(byPasswordCategory: PasswordCategory(rawValue: index) ?? PasswordCategory.other)
    }
}
