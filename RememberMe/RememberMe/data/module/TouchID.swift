//
//  TouchID.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import Foundation
import LocalAuthentication

protocol TouchIDType {
    var successed: () -> Void { get set }
    var failed: (_ message: String) -> Void { get set }
    func check()
}

class TouchID: TouchIDType {
    var successed: () -> Void
    var failed: (_ message: String) -> Void

    var authenticationContext = LAContext()
    var error: NSError?
    
    init(successed: @escaping () -> Void, failed: @escaping (_ message: String) -> Void) {
        self.successed = successed
        self.failed = failed
    }

    func check() {
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            self.failed(error?.localizedDescription ?? "Erro na autenticação")
            return
        }
        
        authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Your password are only for you") { (success, error) in
            if (success) {
                self.successed()
            } else {
                self.failed(error?.localizedDescription ?? "Erro na autenticação")
            }
        }
    }
}
