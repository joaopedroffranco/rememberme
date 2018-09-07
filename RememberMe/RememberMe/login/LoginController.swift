//
//  LoginController.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

protocol LoginControllerInterface {
    func loginProcessing()
    func loginSuccessed()
    func loginFailed(message: String)
}

class LoginController: UIViewController {
    @IBOutlet weak var loginStatusLabel: UILabel! {
        didSet {
            loginStatusLabel.text = "Bem-vindo"
        }
    }
    @IBOutlet weak var tryAgainButton: UIButton! {
        didSet {
            tryAgainButton.isHidden = true
        }
    }

    var loginViewModel: LoginViewModelType! {
        didSet {
            loginViewModel.controller = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.checkTouchID()
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        loginViewModel.tryAgain()
    }
}

extension LoginController: LoginControllerInterface {
    func loginProcessing() {
        loginStatusLabel.text = "Autenticando..."
        tryAgainButton.isHidden = true
    }
    
    func loginSuccessed() {
        loginStatusLabel.text = "Sucesso!"
    }
    
    func loginFailed(message: String = "Erro na autenticação") {
        loginStatusLabel.text = message
        tryAgainButton.isHidden = false
    }
}
