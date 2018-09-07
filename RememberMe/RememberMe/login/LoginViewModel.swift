//
//  LoginViewModel.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewModelType {
    var touchID: TouchIDType! { get set }
    var controller: LoginControllerInterface! { get set }
    
    func checkTouchID()
    func tryAgain()
}

class LoginViewModel: LoginViewModelType {
    var controller: LoginControllerInterface!
    var touchID: TouchIDType!
    
    init() {
        self.touchID = TouchID(successed: {
            DispatchQueue.main.async {
                self.controller.loginSuccessed()
            }
        }, failed: { (message) in
            DispatchQueue.main.async {
                self.controller.loginFailed(message: message)
            }
        })
    }
    
    func checkTouchID() {
        self.controller.loginProcessing()
        touchID.check()
    }
    
    func tryAgain() {
        self.checkTouchID()
    }
}
